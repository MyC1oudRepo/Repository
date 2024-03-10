#--------------------------------------------------------------
# Outputs for VPC and Security Group 
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