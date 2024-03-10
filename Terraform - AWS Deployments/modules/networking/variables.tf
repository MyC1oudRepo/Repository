# -------------------------------------------
# Networking Variables
# -------------------------------------------

variable "region" {
  description = "Region name"
  type        = string
  default     = "eu-central-1"
}

variable "pub_subnets_cidr" {
  description = "CIDR IP Block to be assigned to the public subnets"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr_block" {
  description = "CIDR IP Block to be assigned in VPC"
  type        = string
  default     = null
}

variable "routing_table_cird_block" {
  description = "CIDR IP Block to be assigned in Routing Table"
  type        = string
  default     = "0.0.0.0/0"
}

variable "create_vpc" {
  description = "flag to create a vpc"
  type        = bool
  default     = false
}

variable "create_subnet" {
  description = "flag to create a subnet"
  type        = bool
  default     = false
}