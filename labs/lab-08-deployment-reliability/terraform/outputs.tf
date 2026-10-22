output "ecr_repository_name" {
  value = data.aws_ecr_repository.app.name
}

output "ecr_repository_url" {
  value = data.aws_ecr_repository.app.repository_url
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  value = aws_ecs_service.app.name
}

output "load_balancer_dns" {
  value = aws_lb.app.dns_name
}
