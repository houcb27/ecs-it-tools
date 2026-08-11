variable "vpc_id" {
    description = "VPC ID where the ALB will be created"
    type = string

}

variable "public_subnet_ids" {
    description = "Public subnet needed for ALB"
    type = list(string)
}

variable "certificate_arn" {
    description = "ARN of the ACM certificate"
    type = string
}

variable "environment" {
  type        = string
  description = "Deployment environment"
}