# Setup Guide

## Prerequisites

Install:

- Git
- Docker
- Python 3.12+
- Terraform 1.10+
- AWS CLI
- GitHub account
- AWS account

## GitHub Repository Variables

Create these under:

```text
Repository
→ Settings
→ Secrets and variables
→ Actions
→ Variables
```

Recommended variables:

```text
AWS_ROLE_ARN
AWS_REGION
ECR_REPOSITORY
```

Example:

```text
AWS_REGION=us-east-1
ECR_REPOSITORY=aws-devsecops-pipeline-app
```

## AWS Resources Created Outside Terraform

For this project design, create manually:

1. GitHub OIDC provider in IAM
2. GitHub Actions IAM role
3. Amazon ECR repository
4. S3 bucket for Terraform remote state

The ECS/VPC/ALB infrastructure is managed by Terraform.

## Security Recommendation

Use OIDC instead of long-lived AWS access keys.

## Cleanup

Run Terraform destroy before deleting the state backend:

```bash
cd terraform
terraform init -reconfigure
terraform plan -destroy
terraform destroy
```

Then remove the ECR repository and remote-state bucket only after Terraform successfully destroys managed infrastructure.
