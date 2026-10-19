# AWS DevSecOps GitHub Actions Pipeline

A hands-on cloud engineering lab for building a secure CI/CD pipeline using GitHub Actions, Docker, Terraform, AWS, ECR, ECS Fargate, OIDC, Trivy, and Checkov.

## Lab 1 - Basic Continuous Integration

The first stage of this project implements a basic Python CI pipeline.

### Pipeline

```text
Git Push / Pull Request
        |
        v
GitHub Actions
        |
        v
Checkout Repository
        |
        v
Setup Python
        |
        v
Install Dependencies
        |
        v
Run Unit Tests