module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zone   = ["eu-west-2a", "eu-west-2b"]
  environment         = var.environment
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "it-tools"
  environment     = var.environment
}

module "iam" {
  source      = "./modules/iam"
  region      = var.aws_region
  environment = var.environment
}

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
  environment = var.environment
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn   = module.acm.arn
  environment       = var.environment
}

module "ecs" {
  source                  = "./modules/ecs"
  cluster_name            = var.cluster_name
  service_name            = var.service_name
  task_cpu                = var.task_cpu
  task_memory             = var.task_memory
  container_image         = var.container_image
  container_port          = var.container_port
  vpc_id                  = module.vpc.vpc_id
  desired_count           = var.desired_count
  private_subnet_ids      = module.vpc.private_subnet_ids
  target_group_arn        = module.alb.target_group_arn
  alb_security_group_id   = module.alb.alb_security_group_id
  task_execution_role_arn = module.iam.task_execution_role_arn
  environment             = var.environment
}