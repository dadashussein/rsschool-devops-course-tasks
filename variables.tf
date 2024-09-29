variable "region" {
  description = "The AWS region to deploy resources"
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  default     = "dadodevops"
}

variable "tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}