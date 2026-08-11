variable "vpc_cidr" {
    type = string
    description = "CIDR block for the VPC"
}

variable "environment" {
    type = string
    description = "Deployment environment"
    default = "prod"
}

variable "public_subnet_cidr" {
    type = list(string)
      description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidr" {
    type = list(string)
      description = "CIDR blocks for private subnets"
}

variable "availability_zone" {
    type = list(string)
    description = "Availability zones to deploy subnets into"
}

