resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  tags   = var.tags
}