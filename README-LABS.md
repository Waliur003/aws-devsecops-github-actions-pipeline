# AWS DevSecOps GitHub Actions Pipeline — Lab 1 to Lab 8

This folder is a complete learning archive for a progressive AWS DevSecOps project.

The project starts with basic Python CI and grows into a production-style deployment pipeline using:

- GitHub Actions
- Python / Flask
- Docker
- Trivy
- Terraform
- Checkov
- GitHub OIDC
- AWS IAM
- Amazon ECR
- Amazon ECS Fargate
- Application Load Balancer
- Amazon CloudWatch
- VPC Flow Logs
- AWS KMS
- Terraform remote state
- ECS deployment circuit breaker
- automatic rollback
- Terraform destructive-change protection
- deployment verification
- automated failure diagnostics

---

## Lab Roadmap

| Lab | Topic | Main Outcome |
|---|---|---|
| [Lab 1](labs/lab-01-basic-ci/) | Basic CI | Run Python tests automatically |
| [Lab 2](labs/lab-02-docker-ci/) | Docker CI | Build/run container and health-test it |
| [Lab 3](labs/lab-03-trivy-security/) | Security scanning | Scan repo and image with Trivy |
| [Lab 4](labs/lab-04-terraform-checkov/) | IaC CI | Terraform validate + Checkov |
| [Lab 5](labs/lab-05-aws-oidc/) | AWS authentication | GitHub OIDC to AWS |
| [Lab 6](labs/lab-06-ecr/) | ECR delivery | Immutable Git-SHA image delivery |
| [Lab 7](labs/lab-07-ecs-fargate/) | AWS deployment | Deploy to ECS Fargate behind ALB |
| [Lab 8](labs/lab-08-deployment-reliability/) | Reliability | Rollback, safety gate, verification, diagnostics |

---

## Final Architecture

```text
Developer
   |
   v
GitHub
   |
   v
GitHub Actions
   |
   +--> Python Tests
   |
   +--> Trivy Repository Scan
   |
   +--> Docker Build
   |
   +--> Trivy Image Scan
   |
   +--> Terraform Validate
   |
   +--> Checkov IaC Scan
   |
   v
GitHub OIDC
   |
   v
AWS IAM Role
   |
   v
Amazon ECR
Immutable Git SHA Image
   |
   v
Terraform Plan
   |
   v
Destructive Change Safety Gate
   |
   v
Terraform Apply
   |
   v
VPC + ALB + ECS Fargate
   |
   v
ECS Circuit Breaker
   |
   v
Wait for Service Stability
   |
   v
Verify Running Image SHA
   |
   v
ALB /health Smoke Test
   |
   +--> Deployment Summary
   |
   +--> Failure Diagnostics if needed
```

---

## Recommended Repository Layout

```text
aws-devsecops-github-actions-pipeline/
├── .github/
│   └── workflows/
│       └── ci.yml
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── tests/
│       └── test_app.py
├── docker/
│   └── Dockerfile
├── terraform/
│   ├── alb.tf
│   ├── backend.tf
│   ├── cloudwatch.tf
│   ├── ecs.tf
│   ├── iam.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── security-groups.tf
│   ├── variables.tf
│   ├── versions.tf
│   └── vpc.tf
├── labs/
│   ├── lab-01-basic-ci/
│   ├── lab-02-docker-ci/
│   ├── lab-03-trivy-security/
│   ├── lab-04-terraform-checkov/
│   ├── lab-05-aws-oidc/
│   ├── lab-06-ecr/
│   ├── lab-07-ecs-fargate/
│   └── lab-08-deployment-reliability/
└── README.md
```

---

## Portfolio Skills Demonstrated

- CI/CD engineering
- GitHub Actions
- AWS IAM and OIDC federation
- Infrastructure as Code
- Terraform remote state
- Docker
- container security
- Amazon ECR
- ECS Fargate
- Application Load Balancer
- AWS networking
- CloudWatch logging
- VPC Flow Logs
- KMS encryption
- Trivy
- Checkov
- deployment safety gates
- automatic rollback
- cloud troubleshooting
- DevSecOps practices

---

## Important Note

The files in each lab folder are learning snapshots.

For actual deployment, use the latest Lab 8 versions and replace placeholders such as:

```text
<YOUR_ACCOUNT_ID>
<YOUR_BUCKET_NAME>
<YOUR_GITHUB_USER>
<YOUR_REPOSITORY>
```

with your own values.

Do not commit AWS access keys or secret keys to GitHub.
