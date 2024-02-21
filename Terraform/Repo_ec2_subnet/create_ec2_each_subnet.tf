// Local variables definition for EC2 
locals {
  ec2_ami                = local.ami
  ec2_type               = local.type
  ec2_instance_profile   = local.instance_profile
  #ec2_create_ec2         = local.create_ec2
  ec2_s3_instance_role   = file("../iam/s3-access-role.json")
  ec2_s3_instance_policy = file("../iam/s3-access-policy.json")
}

#--------------------------------------------------------------
# Data Sources
#--------------------------------------------------------------


#--------------------------------------------------------------
# Modules calls
#--------------------------------------------------------------

// Main EC2
module "ec2_instance" {
  count  = length(module.vpc.subnet_id)
  source = "../modules/ec2"

  #create_ec2 = local.ec2_create_ec2

  ec2_ami_id        = local.ami
  ec2_instance_type = local.type
  ec2_subnet_id     = module.vpc.subnet_id[count.index]
  ec2_vpc_id        = module.vpc.vpc_id
  ec2_s3_access     = local.instance_profile
  ec2_sg_id         = [module.security_group.sg_id]
}