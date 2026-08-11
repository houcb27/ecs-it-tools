variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "eu-west-2"
}

variable "vpc_cidr" {
    type = string
    description = "CIDR block for VPC"
    default = "10.0.0.0/16"
}

variable "domain_name" {
    type = string
    description = "Domain name"
    default = "houcinebenzellat.uk"
}

variable "container_image" {
    type = string 
    description = "ECR image URI for container"
    default = "545892166560.dkr.ecr.eu-west-2.amazonaws.com/it-tools"
}

variable "environment" {
    type = string
    description = "Deployment environment"
    default = "prod"
}

variable "task_memory" {
    type = number
    default = 512
    description = "Memory for ECS task"
}

variable "desired_count" {
    type = number
    description = "Number of ECS tasks to run"
    default = 1
}
variable "task_cpu" {
    type = number
    description = "CPU for ECS task"
    default = 256
}

variable "availability_zone" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "public_subnet_cidr" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "cluster_name" {
    description = "Name of ECS cluster"
    type = string
    default = "it-tool-cluster"
}

variable "service_name" {
    description = "Name of ECS service"
    type = string
    default = "it-tool-service"
}

variable "container_port" {
    description = "Port of ECR image"
    type = number
    default = 80
}