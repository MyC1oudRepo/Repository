// Local variables
locals {
  s3_bucket_name   = "bucket-for-myclouddomain"
  create_bucket    = true
}

#--------------------------------------------------------------
# Modules calls
#--------------------------------------------------------------

// Main S3
module "s3_bucket" {
  source = "../modules/s3"

  #create_bucket = local.create_bucket
  bucket_name   = local.s3_bucket_name
}