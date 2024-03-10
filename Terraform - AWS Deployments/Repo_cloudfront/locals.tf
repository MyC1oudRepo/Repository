// Local variables definition for Cloudfront
locals {
  ami                = "ami-0669b163befffbdfc"
  type               = "t2.micro"

  //Flag to create different resources
  #create_bucket     = false
  #create_elb        = false
  #create_cloudfront = false
  #create_ec2        = false
  #create_ec2_s3     = false
}
