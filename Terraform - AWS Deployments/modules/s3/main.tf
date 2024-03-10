# ------------------------------------------------------------------------------
# AWS S3 Bucket module
# ------------------------------------------------------------------------------

// S3 Bucket
resource "aws_s3_bucket" "this" {
  count = var.create_s3 ? 1 : 0

  bucket = var.bucket_name
  tags = {
    Name        = var.bucket_name
    Environment = "AWS Project"
  }
}

// S3 bucket block public access
resource "aws_s3_bucket_public_access_block" "this" {
  count = var.create_s3 ? 1 : 0

  bucket                  = aws_s3_bucket.this[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

// S3 bucket onwership
resource "aws_s3_bucket_ownership_controls" "this" {
  count = var.create_s3 ? 1 : 0

  bucket = aws_s3_bucket.this[0].id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.this]
}

// S3 ACL
resource "aws_s3_bucket_acl" "this" {
  count = var.create_s3? 1 : 0

  bucket = aws_s3_bucket.this[0].id
  depends_on = [aws_s3_bucket_ownership_controls.this]
  acl        = "private"
}

// S3 bucket website configuration
resource "aws_s3_bucket_website_configuration" "this" {
  count = var.create_s3? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


//Upload index.html to S3 bucket
resource "aws_s3_object" "UploadIndex" {
  count = var.create_s3 ? 1 : 0

  bucket       = aws_s3_bucket.this[0].id
  key          = "index.html"
  source       = "../cdn/files/index.html"
  content_type = "text/html"
  etag         = filemd5("../cdn/files/index.html")
}

//Upload image.jpg to S3 bucket
resource "aws_s3_object" "UploadImage" {
  count = var.create_s3 ? 1 : 0

  bucket       = aws_s3_bucket.this[0].id
  key          = "image.jpg"
  source       = "../cdn/files/image.jpg"
  content_type = "image/jpg"
  etag         = filemd5("../cdn/files/image.jpg")
}