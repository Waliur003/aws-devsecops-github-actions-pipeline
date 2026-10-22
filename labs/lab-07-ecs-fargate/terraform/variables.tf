variable "aws_region" {
  description = "AWS region used by the lab"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "aws-devsecops-pipeline"
}

variable "container_image" {
  description = "Docker image URI used by the ECS task"
  type        = string
  default     = "public.ecr.aws/docker/library/python:3.12-slim"
}
