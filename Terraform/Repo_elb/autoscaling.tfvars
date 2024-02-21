// Variables list

# Common
project2 = "myec2autoscaling"

# General 
aws_region = "us-east-1"

# LB is creating only 1 ENI. it should be number of subnet provided

# Load Balancer
lb_name                       = "mylb"
lb_internal                   = false
lb_load_balancer_type         = "application"
lb_security_groups            = ["sg-########"]
lb_subnets                    = ["subnet-########", "subnet-########"]
lb_enable_deletion_protection = false
lb_target_port                = 80
lb_protocol                   = "HTTP"
lb_target_type                = "instance" # While using LB with ASG (Auto Scaling Group , the type must be 'instance' not ip)
vpc_id                        = "vpc-########"
lb_listener_port              = 80
lb_listener_protocol          = "HTTP"

# Launch Template

image_id               = "ami-0669b163befffbdfc"
instance_type          = "t2.micro"
key_name               = "mykey"
vpc_security_group_ids = ["sg-########"]


# Auto Scaling
max_size              = 4
min_size              = 2
desired_capacity      = 2
asg_health_check_type = "ELB"
target_group_arns     = []
