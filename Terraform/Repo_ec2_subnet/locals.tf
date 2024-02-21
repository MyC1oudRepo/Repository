// Local variables definition for EC2
locals {
  ami                = "ami-0669b163befffbdfc"
  type               = "t2.micro"
  instance_profile   = null
  //Flag to create different resources
/*  create_bucket     = true
  create_elb        = true
  create_cloudfront = true
  create_ec2        = true
  create_ec2_s3     = true */
}
