variable "region" {
  description = "Defines AWS region"
  default     = "eu-central-1"
  type        = string
}

variable "vpc" {
  type = object({
    cidr_block = string
    tag        = string
  })
  default = {
    cidr_block = "10.0.0.0/16"
    tag        = "vpc"
  }
}

variable "igw" {
  type = object({
    tag = string
  })
  default = {
    tag = "igw"
  }
}

variable "public_subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tag               = string
  }))
  default = [{
    cidr_block        = "10.0.1.0/24"
    availability_zone = "eu-central-1a"
    tag               = "public_subnet"
  }]
}

variable "private_subnets" {
  type = list(object({
    cidr_block        = string
    nat_gw_subnet     = string
    availability_zone = string
    tag               = string
  }))
  default = [{
    cidr_block        = "10.0.2.0/24"
    nat_gw_subnet     = "10.0.1.0/24"
    availability_zone = "eu-central-1a"
    tag               = "private_subnet"
  }]
}