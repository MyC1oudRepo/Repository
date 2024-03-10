# -------------------------------------------
# Security Group Variables
# -------------------------------------------

variable "vpcid" {
  description = "ID of the VPC in which EC2 is created"
  type        = string
}

variable "inbound_ports" {
  description = "Inbound ports for the Security Group"
  type        = list(number)
}

/*
variable "create_sg" {
  description = "flag to create or not a security group"
  type        = bool
  default     = false
}
*/