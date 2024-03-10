# ------------------------------------------------------------------------------
# Amazon EC2 Instance module
# ------------------------------------------------------------------------------

// Local variables definition

#--------------------------------------------------------------
# Data Sources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Resources
#--------------------------------------------------------------

// EC2 Instance
resource "aws_instance" "my_ec2" {
  #count = var.create_ec2 ? 1 : 0

  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.ec2_subnet_id
  iam_instance_profile   = var.ec2_s3_access
  vpc_security_group_ids = var.ec2_sg_id
  user_data              = filebase64("${path.root}/scripts/apache_install.sh")
  metadata_options {
    http_tokens = "optional"
  }

  tags = {
    Name = "my_testing_ec2"
    ResourceName = "myec2autoscaling"
  }
}