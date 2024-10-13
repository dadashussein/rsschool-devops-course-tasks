variable "region" {
  default = "eu-central-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for private subnet 1"
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for private subnet 2"
  default     = "10.0.4.0/24"
}

variable "tags" {
  description = "Tags for AWS resources"
  type        = map(string)
  default = {
    Name        = "task-2-vpc"
    Environment = "Development"
  }
}


variable "ami_id" {
  description = "Amazon Linux 2 AMI for the Bastion Host"
  default     = "ami-011f11b2ae563e78c"
}

variable "key_name" {
  description = "Key pair to access the bastion host"
  default     = "my-key-pair" 
}

variable "nat_instance_ami" {
  description = "AMI for NAT instance (Amazon Linux 2 with NAT preconfigured)"
  default     = "ami-011f11b2ae563e78c"
}