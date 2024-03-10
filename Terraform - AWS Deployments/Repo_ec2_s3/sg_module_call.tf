// List of inbound ports
variable "inbound_ports" {
  description = "Inbound ports for the Security Group"
  type        = list(number)
  default     = [22, 80]
}

#--------------------------------------------------------------
# Modules calls
#--------------------------------------------------------------

// Main SG creation
module "security_group" {
  source     = "../modules/security_group"
  
  #create_sg  = local.create_sg
  vpcid = module.vpc.vpc_id
  inbound_ports = var.inbound_ports
  
  depends_on = [module.vpc]
}