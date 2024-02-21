# ------------------------------------------------------------------------------
# Amazon Cloudfront module
# ------------------------------------------------------------------------------

// Local variables definition
locals {
  s3_origin_id                   = "${var.s3_name}-origin"
  s3_domain_name                 = "${var.s3_name}.${var.region}.amazonaws.com"
  s3_bucket_domain_name          = var.s3_bucket_domain_name
  domain_name = "myclouddomain.net"
  myclouddomain_domain_name        = "myclouddomain.net"
  myclouddomain_ttl                = 60 # Default: 3600
  myclouddomain_overwrite          = false
  myclouddomain_validation_name    = "_e427802a334e244f971c7200c12b3ddf.myclouddomain.net."
  myclouddomain_validation_records = ["_2b6ba6a655e71b11170c049723fc509b.mhbtsbpdnt.acm-validations.aws."]
}

// The region of the certificate provider
provider "aws" {
  region = "us-east-1"
}

#--------------------------------------------------------------
# Data Sources
#--------------------------------------------------------------

// Certificate for domain name myclouddomain.net
data "aws_acm_certificate" "certificate" {
  domain      = local.myclouddomain_domain_name
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

// Caching policy for cloudfront
data "aws_cloudfront_cache_policy" "cf_cache_policy" {
  #name = "Managed-CachingOptimized"
  name = "Managed-CachingDisabled"
}


#--------------------------------------------------------------
# Resources
#--------------------------------------------------------------


// New hosted zone: myclouddomain.net
resource "aws_route53_zone" "myclouddomain" {
  name = local.myclouddomain_domain_name
}

// Update domain name servers with hosted zone name servers
resource "aws_route53domains_registered_domain" "myclouddomain" {
  domain_name = aws_route53_zone.myclouddomain.name

  dynamic "name_server" {
    for_each = toset(aws_route53_zone.myclouddomain.name_servers)
    content {
      name = name_server.value
    }
  }
}

/*
// Nameservers records
resource "aws_route53_record" "myclouddomain_nameservers" {
  name            = local.myclouddomain_domain_name
  ttl             = local.myclouddomain_ttl
  type            = "NS"
  zone_id         = aws_route53_zone.myclouddomain.zone_id
  allow_overwrite = local.myclouddomain_overwrite
  records         = aws_route53_zone.myclouddomain.name_servers
}
*/

// Cloudfront distribution alias record
resource "aws_route53_record" "myclouddomain_alias_record_apex" {
  name            = local.myclouddomain_domain_name
  type            = "A"
  zone_id         = aws_route53_zone.myclouddomain.zone_id
  allow_overwrite = local.myclouddomain_overwrite

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

// Cloudfront distribution alias record www
resource "aws_route53_record" "www_myclouddomain_alias_record_apex" {
  name            = "www.${local.myclouddomain_domain_name}"
  type            = "A"
  zone_id         = aws_route53_zone.myclouddomain.zone_id
  allow_overwrite = local.myclouddomain_overwrite

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

// Certificate validation records
resource "aws_route53_record" "myclouddomain_certificate_validation_record_myclouddomain" {
  name            = local.myclouddomain_validation_name
  records         = local.myclouddomain_validation_records
  type            = "CNAME"
  ttl             = local.myclouddomain_ttl
  zone_id         = aws_route53_zone.myclouddomain.zone_id
  allow_overwrite = local.myclouddomain_overwrite
}


// Cloudfront origin access control configuration
resource "aws_cloudfront_origin_access_control" "this" {
  #count = var.create_cloudfront ? 1 : 0

  name                              = "OAC"
  description                       = "Origin Access Control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


// Cloudfront deployment
resource "aws_cloudfront_distribution" "this" {
  
  #count = var.create_cloudfront ? 1 : 0  # if create_my_cloudfront is true, 1 instance will be created
                                            # if create_my_cloudfront is false, 0 instance will be created
  
  enabled = true

  origin {
    origin_id                = local.s3_origin_id
    domain_name              = local.s3_bucket_domain_name
    #origin_access_control_id = aws_cloudfront_origin_access_control.this[0].id
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  default_root_object = "index.html"

  aliases = ["myclouddomain.net"]


  default_cache_behavior {

    target_origin_id = local.s3_origin_id
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    cache_policy_id  = data.aws_cloudfront_cache_policy.cf_cache_policy.id

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    #cloudfront_default_certificate = true
    #acm_certificate_arn = "arn:aws:acm:us-east-1:120561461764:certificate/c47b3dd0-b1ed-4874-94e8-0d15d9820f22"
    acm_certificate_arn = data.aws_acm_certificate.certificate.arn
    ssl_support_method  = "sni-only"
  }

  price_class = "PriceClass_200"
}