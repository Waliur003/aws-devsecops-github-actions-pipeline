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