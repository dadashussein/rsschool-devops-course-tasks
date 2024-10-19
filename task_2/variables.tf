variable "region" {
  default = "eu-central-1"
}

# Networking Variables

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

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}


variable "ec2_amazon_linux_ami" {
  description = "EC2 Instance Image for Bastion Host and Testing"
  default     = "ami-0e6a13e7a5b66ff4d"
}

variable "ssh_pk" {
  description = "SSH Public Key to connect to Bastion Host"
  type        = string
}

variable "ssh_inbound_ip" {
  description = "Specify CIDR block to limit inbound ssh traffic to the NAT Instance/Bastion Host"
  default     = ["0.0.0.0/0"]
}