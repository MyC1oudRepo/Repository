// Local variables definition EC2
locals {
  ami                = "ami-0669b163befffbdfc"
  type               = "t2.micro"

  //Flag to create different resources
  create_bucket     = false
  create_ec2        = false
  create_ec2_s3     = false
}