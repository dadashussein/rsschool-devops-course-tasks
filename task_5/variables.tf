# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu 22.04"
  type        = string
  default     = "ami-0039da1f3917fa8e3"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "jenkins"
}