# -------------------------------------------
# S3 Bucket Variables
# -------------------------------------------

variable "bucket_name" {
  description = "Bucket name"
  type        = string
  default     = null
}

variable "create_s3" {
  description = "Flag to crete or not a bucket"
  type        = bool
  default     = true
}