// Local variables definition for ELB
locals {
  tags = {
    Project     = "myec2autoscaling"
    createdby   = "Diana"
    CreatedOn   = timestamp()
    Environment = terraform.workspace
  }
  #create_my_elb = false

  # General 
  aws_region = "eu-central-1"


  # LB is creating only 1 ENI. it should be number of subnet provided

  // Load Balancer
  lb_name                        = "mylb"
  lb_internal                    = false
  lb_load_balancer_type          = "application"
  #lb_security_groups           = ["sg-########"]
  #lb_subnets                   = ["subnet-########", "subnet-########"]
  lb_enable_deletion_protection = false
  lb_target_port                = 80
  lb_protocol                   = "HTTP"
  lb_target_type                = "instance" # While using LB with ASG (Auto Scaling Group , the type must be 'instance' not ip)
  vpc_id                        = "vpc-########"
  lb_listener_port              = 80
  lb_listener_protocol          = "HTTP"
}

#--------------------------------------------------------------
# Modules calls
#--------------------------------------------------------------

// Load Balancer
module "elb" {
  source = "../modules/elb"

  #create_elb = local.create_my_elb

  name                       = local.lb_name
  internal                   = local.lb_internal
  load_balancer_type         = local.lb_load_balancer_type
  security_groups            = [module.security_group.sg_id]
  subnets                    = module.vpc.subnet_id
  enable_deletion_protection = local.lb_enable_deletion_protection

  lb_target_port = local.lb_target_port
  lb_protocol    = local.lb_protocol
  lb_target_type = local.lb_target_type
  vpc_id         = module.vpc.vpc_id

  lb_listener_port     = local.lb_listener_port
  lb_listener_protocol = local.lb_listener_protocol

  tags = local.tags
}