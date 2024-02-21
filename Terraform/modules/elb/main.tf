# ------------------------------------------------------------------------------
# Amazon Load Balancer module
# ------------------------------------------------------------------------------

// Local variables definition

#--------------------------------------------------------------
# Data Sources
#--------------------------------------------------------------

// Filter to fetch multiple instances: aws_instances
data "aws_instances" "this" {
  filter {
    name   = "tag:ResourceName"
    values = ["myec2autoscaling"]
  }
}

#--------------------------------------------------------------
# Resources
#--------------------------------------------------------------

// ELB resource
resource "aws_lb" "this" {
  #count = var.create_elb ? 1 : 0

  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type #"application" or "network"
  security_groups    = var.security_groups    #[aws_security_group.lb_sg.id]
  subnets            = var.subnets            #[for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = var.enable_deletion_protection #true

  tags = merge({ "Name" = var.name }, var.tags)
}


// ELB target group
resource "aws_lb_target_group" "this" {
  #count = var.create_elb ? 1 : 0

  name        = "tg-${var.name}"
  port        = var.lb_target_port
  protocol    = var.lb_protocol    #"HTTP"
  target_type = var.lb_target_type #"ip" for ALB/NLB, "instance" for autoscaling group, 
  vpc_id      = var.vpc_id
  tags        = merge({ "Name" = "tg-${var.name}" }, var.tags)

}

// ELB listener
resource "aws_lb_listener" "this" {
  #count = var.create_elb ? 1 : 0
  #load_balancer_arn = aws_lb.this[0].arn

  load_balancer_arn = aws_lb.this.arn
  port              = var.lb_listener_port     #"443"
  protocol          = var.lb_listener_protocol #"TLS"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  #alpn_policy       = "HTTP2Preferred"

  default_action {
    type             = "forward"
    #target_group_arn = aws_lb_target_group.this[0].arn
    target_group_arn = aws_lb_target_group.this.arn
  }
}


// ELB target group attachment
resource "aws_lb_target_group_attachment" "this" {
  #count = var.create_elb ? length(data.aws_instances.this.ids) : 0
  #target_group_arn = aws_lb_target_group.this[0].arn

  count            = length(data.aws_instances.this.ids)
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = data.aws_instances.this.ids[count.index] #data.aws_instance.this.id
  port             = var.lb_target_port                       # 80
}