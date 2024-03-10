//S3 bucket to store the tfstate
terraform {
  backend "s3" {
    bucket = "uns3bucketfortfstate"
    key    = "repo_cdn/terraform.tfstate"
    region = "eu-central-1"
  }
}