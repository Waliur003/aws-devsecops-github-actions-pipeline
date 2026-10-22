data "aws_caller_identity" "current" {}

data "aws_ecr_repository" "app" {
  name = "${var.project_name}-app"
}