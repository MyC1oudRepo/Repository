#--------------------------------------------------------------
# Cloudfront Outputs
#--------------------------------------------------------------

output "cloudfront_domain_name" {
  description = "Cloudfront domain name"
  #value = var.create_cloudfront ? aws_cloudfront_distribution.this[0].domain_name : null
  value = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_hosted_zone_id" {
  description = "Cloudfront hosted zone id"
  #value = var.create_cloudfront ? aws_cloudfront_distribution.this[0].hosted_zone_id : null
  value = aws_cloudfront_distribution.this.hosted_zone_id
}

output "cloudfront_certificate_id" {
  description = "Cloudfront certificate id"
  value = data.aws_acm_certificate.certificate.id
}

output "cloudfront_certificate" {
  description = "Cloudfront certificate name"
  value = data.aws_acm_certificate.certificate.certificate
}