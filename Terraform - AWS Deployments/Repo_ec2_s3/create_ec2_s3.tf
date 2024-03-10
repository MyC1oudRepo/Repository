// Local variables definition for EC2 and S3
locals {
  ec2_s3_bucket_name   = "uns3bucket-cloudfront-20231221"
  ec2_s3_ami           = local.ami
  ec2_s3_type          = local.type
  ec2_s3_create_ec2    = true
  ec2_s3_create_s3     = true
}


#--------------------------------------------------------------
# Data Sources
#--------------------------------------------------------------


#--------------------------------------------------------------
# Resources
#--------------------------------------------------------------

# Create Instance profile
resource "aws_iam_instance_profile" "ec2_s3_access_instance_profile" {
  name = "my-instance-profile"
  role = aws_iam_role.ec2_s3_access_iam_role.name
}

resource "aws_s3_bucket_policy" "allow_access_to_s3" {
  bucket = module.ec2_s3_bucket.bucket_id
  policy = data.aws_iam_policy_document.allow_access_to_s3.json
}



#--------------------------------------------------------------
# Modules calls
#--------------------------------------------------------------

//S3 bucket as cloudfront origin
module "ec2_s3_bucket" {
  source         = "../modules/s3"

  create_s3      = local.ec2_s3_create_s3
  bucket_name    = local.ec2_s3_bucket_name
}

module "ec2_s3_instance" {
  source = "../modules/ec2"

  #create_ec2        = local.ec2_s3_create_ec2
  ec2_ami_id        = local.ami
  ec2_instance_type = local.type
  ec2_subnet_id     = module.vpc.subnet_id[0]
  ec2_vpc_id        = module.vpc.vpc_id
  ec2_s3_access     = aws_iam_instance_profile.ec2_s3_access_instance_profile.id
  ec2_sg_id         = [module.security_group.sg_id]
}

