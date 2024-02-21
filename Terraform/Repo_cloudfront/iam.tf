#--------------------------------------------------------------
# IAM Locals
#--------------------------------------------------------------

locals{
cloudfront_s3_instance_role   = file("../iam/cloudfront-s3-access-role.json")
cloudfront_s3_instance_policy = file("../iam/cloudfront-s3-access-policy.json")
}

#--------------------------------------------------------------
# Data Sources
#--------------------------------------------------------------

// S3 bucket policy template 
data "template_file" "cloudfront_s3_access_iam_template" {
  template = local.cloudfront_s3_instance_policy
  vars = {
    bucket_arn = module.s3_bucket.bucket_arn
  }
}

// Allow access policy
data "aws_iam_policy_document" "allow_access_to_s3" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_bucket.bucket_arn}/*"]
  }
}

#--------------------------------------------------------------
# Resources
#--------------------------------------------------------------

// IAM Role
resource "aws_iam_role" "cloudfront_s3_access_iam_role" {
  name               = "cloudfront-s3-access-iam-role"
  assume_role_policy = local.cloudfront_s3_instance_role
  #tags = local.tags
}

# IAM Policy assigned to S3 Bucket
resource "aws_s3_bucket_policy" "cloudfront_s3_access_bucket_policy" {
  bucket = local.s3_bucket_name
  policy = data.template_file.cloudfront_s3_access_iam_template.rendered
}