#--------------------------------------------------------------
# S3 Bucket Outputs
#--------------------------------------------------------------

output "bucket_arn"{
   description = "Bucket ARN"
   value       = aws_s3_bucket.this[0].arn
}

output "bucket_id"{
   description = "Bucket ID"
   value       = aws_s3_bucket.this[0].id
}