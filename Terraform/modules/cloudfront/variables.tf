#--------------------------------------------------------------
# Cloudfront variables file 
#--------------------------------------------------------------

variable "region" {
  description = "Region name"
  type    = string
  default = "eu-central-1"
}

variable "s3_name" {
  description = "Cloudfron S3 origin name"
  type    = string
  default = "myclouddomain.net"
}

variable "s3_bucket_domain_name" {
  description = "S3 bucket domain name"
  type    = string
  default = "bucket-for-cloudfront.s3.amazonaws.com"
}

/*
variable "create_cloudfront" {
  type    = bool
  default = false
}
*/