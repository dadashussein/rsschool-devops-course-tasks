resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "aws-devops-terraform-vpc"
    Environment = "Production"
    Project     = "Kubernetes Cluster"
  }
}
