#--------------------------------------------------------------
# Website
#--------------------------------------------------------------

// Local variables definition
locals {
  cdn_region     = "eu-central-1"
  #cdn_s3_name    = "myclouddomain.net"
}

#--------------------------------------------------------------
# Data Sources
#--------------------------------------------------------------

// Get S3 bucket ID
data "aws_s3_bucket" "selected" {
  bucket = module.s3_bucket.bucket_id
}


#--------------------------------------------------------------
# Modules calls
#--------------------------------------------------------------

//Cloudfront module
module "my_cloudfront" {
  source                 = "../modules/cloudfront"
  region                = local.cdn_region
  s3_name               = local.s3_bucket_name
  s3_bucket_domain_name = data.aws_s3_bucket.selected.bucket_domain_name

  #create_cloudfront = false
}