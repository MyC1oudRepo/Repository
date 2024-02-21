#--------------------------------------------------------------
# Cloudfront Outputs
#--------------------------------------------------------------

output "Cloudfront_Bucket_ARN" {
  description = "Bucket ARN used as origin by Cloudfront"
  value       = module.s3_bucket.bucket_arn
}

output "Cloudfront_Bucket_domain_name" {
  description = "Bucket domain name used as origin by Cloudfront"
  value       = data.aws_s3_bucket.selected.bucket_domain_name
}
