//S3 bucket to store the tfstate
terraform {
  backend "s3" {
    bucket = "uns3bucketfortfstate"
    key    = "repo_elb/terraform.tfstate"
    region = "eu-central-1"
  }
}