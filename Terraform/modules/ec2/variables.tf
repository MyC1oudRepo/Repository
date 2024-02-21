#--------------------------------------------------------------
# EC2 variables file 
#--------------------------------------------------------------

variable "ec2_ami_id" {
  description = "EC2 instance ami"
  type        = string
  default     = null
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = null
}

variable "ec2_subnet_id" {
  description = "EC2 subnet id"
  type        = string
  default     = null
}

variable "ec2_vpc_id" {
  description = "ID of the VPC in which EC2 is created"
  type        = string
}

variable "ec2_s3_access" {
  description = "EC2 access"
  type        = string
  default     = null
}

variable "ec2_sg_id" {
  description = "SG assigned to ec2"
  type        = list(string)
  default     = null
}

/*variable "create_ec2" {
  description = "flag to create an ec2 instance"
  type        = bool
  default     = true
}*/