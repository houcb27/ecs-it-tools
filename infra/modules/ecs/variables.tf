variable "cluster_name" {
    description = "Name of ECS cluster"
    type = string
}

variable "service_name" {
    description = "Name of ECS service"
    type = string
}

variable "task_cpu" {
    description = "Amount of CPU used"
    type = number 
}

variable "task_memory" {
    description = "Amount of memory used"
    type = number
}

variable "container_image" {
    description = "Which Docker image to run"
    type = string
}

variable "container_port" {
    description = "Port of conatiner"
    type = number
}

variable "vpc_id" {
    description = "VPC for ECS security group"
    type = string 
}

variable "desired_count" {
    description = "How many tasks to run"
    type = number
}

variable "private_subnet_ids" {
    description = "Where to run tasks in VPC"
    type = list(string)
}

variable "target_group_arn" {
    description = "Connects ECS service to ALB"
    type = string
}

variable "alb_security_group_id" {
    description = "ECS security group"
    type = string 
}

variable "environment" {
    description = "Deployment environment"
    type = string 
  
}

variable "task_execution_role_arn" {
    description = "IAM role attached to task definition"
    type = string
}