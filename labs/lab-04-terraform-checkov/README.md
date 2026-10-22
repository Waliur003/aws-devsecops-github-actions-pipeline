# Lab 4 — Terraform Validation + Checkov

## Goal

Add Infrastructure as Code validation and IaC security scanning.

## Flow

```text
Terraform
   |
   +--> terraform fmt
   |
   +--> terraform init -backend=false
   |
   +--> terraform validate
   |
   v
Checkov
   |
   v
IaC Security Gate
```

## Commands

```bash
terraform fmt -check -recursive
terraform init -backend=false -input=false
terraform validate
```

## Checkov

Checkov checks Terraform for common security problems.

Examples include:

- public exposure
- missing encryption
- weak logging
- insecure networking
- missing hardening controls

## Intentional Exceptions

For learning infrastructure, some checks can be intentionally skipped, but each skip should include a reason beside the exact resource.

Avoid blanket disabling rules.

## Interview Explanation

> Lab 4 introduces IaC quality and security gates. Terraform is formatted and validated, then Checkov scans the infrastructure before AWS deployment is allowed.
