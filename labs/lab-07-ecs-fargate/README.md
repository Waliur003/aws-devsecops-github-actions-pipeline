# Lab 7 — ECS Fargate + ALB Deployment

## Goal

Deploy the secure ECR image into AWS ECS Fargate through Terraform.

## Architecture

```text
Internet
   |
   v
Application Load Balancer
   |
   v
ALB Security Group
   |
 TCP 5000
   |
   v
ECS Security Group
   |
   v
ECS Fargate Task
   |
   v
Flask Application
```

## Terraform Infrastructure

- custom VPC
- two subnets
- Internet Gateway
- route table
- ALB
- target group
- listener
- security groups
- ECS cluster
- task definition
- Fargate service
- ECS execution role
- CloudWatch logs
- VPC Flow Logs
- KMS encryption

## Remote State

Terraform uses an S3 backend and lock file.

## Deployment Flow

```text
ECR Image
   |
   v
Terraform Plan
   |
   v
Saved Plan Artifact
   |
   v
Terraform Apply
   |
   v
ECS Fargate
   |
   v
ALB /health
```

## Important Troubleshooting Lesson

If a Terraform apply partially succeeds and changes state, an old saved plan can become stale.

Correct action:

```text
Re-run all jobs
```

so a fresh plan is generated.

## Cost-Aware Design

This learning version uses public Fargate task IPs instead of a NAT Gateway.

A production design would normally use private subnets and controlled outbound connectivity.

## Files

- `terraform/` — full Terraform stack
- `workflow/ci.yml` — deployment pipeline
- `iam/terraform-infrastructure-policy.json` — example CI role policy
