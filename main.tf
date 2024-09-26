provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "dadodevops"
  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}
