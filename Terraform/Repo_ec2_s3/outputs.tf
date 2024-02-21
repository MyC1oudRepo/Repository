#--------------------------------------------------------------
# Cloudfront Outputs
#--------------------------------------------------------------

//VPC ID and the list of subnets within the VPC
output "my_vpc_id" {
  description = "ID of the my vpc"
  value       = module.vpc.vpc_id
}

output "my_subnet_id" {
  description = "List of my subnets"
  value       = module.vpc.subnet_id
}

//Security group ID
output "my_sg_id" {
  description = "ID of the my security group"
  value       = module.security_group.sg_id
}

//Profile ID and Profile name to be assigned to EC2 in order to access s3 bucket
output "ec2_s3_access_profile_id" {
  description = "Profile ID"
  value = aws_iam_instance_profile.ec2_s3_access_instance_profile.id
}

output "ec2_s3_access_profile_name" {
  description = "Profile name"
  value = aws_iam_instance_profile.ec2_s3_access_instance_profile.name
}

//Cloudfront Bucket ARN
output "Cloudfront_Bucket_ARN" {
  description = "Bucket ARN used as origin by the Cloudfront"
  value       = module.ec2_s3_bucket.bucket_arn
}