# Variables

variable "ssh-key" {
  description = "SSH key name"
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDjPkzBydHbNuiiyZVo0PX/DULSWErfnP6JpBEU4LQKj huseynzade.dadas@gmail.com"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "eu-west-2a"
}
