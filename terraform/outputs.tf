output "ecr_repository_name" {
  description = "Name of the existing ECR repository"
  value       = data.aws_ecr_repository.app.name
}

output "ecr_repository_url" {
  description = "URL of the existing ECR repository"
  value       = data.aws_ecr_repository.app.repository_url
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.app.name
}

output "load_balancer_dns" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}