# Lab 8 — Deployment Reliability and Safety

## Goal

Turn the Lab 7 deployment into a safer production-style DevSecOps pipeline.

## Step 1 — Concurrency Protection

```yaml
concurrency:
  group: devsecops-${{ github.ref }}
  cancel-in-progress: false
```

A second deployment waits instead of cancelling Terraform mid-apply.

## Step 2 — ECS Stability + Rollback

The ECS service adds:

```hcl
deployment_minimum_healthy_percent = 100
deployment_maximum_percent         = 200
wait_for_steady_state              = true

deployment_circuit_breaker {
  enable   = true
  rollback = true
}
```

If the new deployment cannot become healthy, ECS can restore the previous successful version.

## Step 3 — Destructive-Change Safety Gate

Terraform plan is exported to JSON.

A Python script:

- allows ECS task-definition replacement
- blocks unexpected resource deletion/replacement

Examples blocked:

- VPC
- ALB
- security group
- ECS service
- networking resources

## Step 4 — Verify Exact Running Image

The workflow:

1. finds the running ECS task
2. reads its task definition
3. gets the actual container image
4. compares the image tag to `${{ github.sha }}`

This verifies deployment traceability.

## Step 5 — Automatic Failure Diagnostics

On failure, collect:

- ECS service data
- service events
- running tasks
- stopped tasks
- stop reasons
- container exit codes
- recent CloudWatch logs

Upload them as a workflow artifact.

## Step 6 — Final Documentation

The project README should explain:

- architecture
- services
- security controls
- deployment flow
- rollback strategy
- troubleshooting
- cleanup

## Final Pipeline

```text
Git Push
   |
   v
Python Tests
   |
   v
Trivy Repository Scan
   |
   v
Docker Build + Trivy
   |
   v
Terraform Validate + Checkov
   |
   v
OIDC -> AWS
   |
   v
Immutable ECR SHA Image
   |
   v
Terraform Plan
   |
   v
Destructive Change Gate
   |
   v
Terraform Apply
   |
   v
ECS Circuit Breaker
   |
   v
Wait for Stability
   |
   v
Verify Running Image SHA
   |
   v
ALB /health
   |
   v
Deployment Summary
   |
   +--> Failure Diagnostics if needed
```

## Interview Explanation

> I extended the pipeline beyond basic deployment by adding concurrency protection, Terraform destructive-change detection, ECS circuit breaker rollback, service stability checks, exact image verification, and automated diagnostics. This makes the project closer to a real production deployment workflow.
