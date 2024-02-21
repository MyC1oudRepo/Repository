#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------

// Local variables
locals{
ec2_s3_s3_instance_role   = file("../iam/s3-access-role.json")
ec2_s3_s3_instance_policy = file("../iam/s3-access-policy.json")
}

#--------------------------------------------------------------
# Data Sources
#--------------------------------------------------------------

// S3 bucket policy template 
data "template_file" "ec2_s3_access_iam_template" {
  template = local.ec2_s3_s3_instance_policy
  vars = {
    bucket_arn = module.ec2_s3_bucket.bucket_arn
  }
}

// Allow access policy
data "aws_iam_policy_document" "allow_access_to_s3" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${module.ec2_s3_bucket.bucket_arn}/*"]
  }
}

#--------------------------------------------------------------
# Resources
#--------------------------------------------------------------

// IAM Role
resource "aws_iam_policy" "ec2_s3_access_iam_policy" {
  name        = "s3-access-iam-policy"
  policy      = data.template_file.ec2_s3_access_iam_template.rendered
  #tags = local.tags
}

# IAM Policy assigned to S3 Bucket
resource "aws_iam_role" "ec2_s3_access_iam_role" {
  name               = "s3-access-iam-role"
  assume_role_policy = local.ec2_s3_s3_instance_role
  #tags = local.tags
}

// Role-Policy attatchment
resource "aws_iam_role_policy_attachment" "ec2_s3_access_attachment" {
  role       = aws_iam_role.ec2_s3_access_iam_role.name
  policy_arn = aws_iam_policy.ec2_s3_access_iam_policy.arn
}


#--------------------------------------------------------------
# Modules Calls
#--------------------------------------------------------------