output "cluster_arn" {
  description = "ECS Cluster arn"
  value       = aws_ecs_cluster.main.arn
}

output "cluster_name" {
  description = "Name of ECS cluster"
  value       = aws_ecs_cluster.main.id
}

output "service_name" {
  description = "Name of ECS service"
  value       = aws_ecs_service.main.id
}