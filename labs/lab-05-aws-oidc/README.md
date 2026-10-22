# Lab 5 — GitHub OIDC to AWS

## Goal

Authenticate GitHub Actions to AWS without storing permanent AWS keys.

## Authentication Flow

```text
GitHub Actions
      |
      v
GitHub OIDC Token
      |
      v
AWS IAM OIDC Provider
      |
      v
AWS STS
      |
      v
GitHubActionsDevSecOpsRole
```

## GitHub Variables

```text
AWS_ROLE_ARN
AWS_REGION
```

## Required Workflow Permissions

```yaml
permissions:
  id-token: write
  contents: read
```

## Verification

Run:

```bash
aws sts get-caller-identity
```

## Why OIDC Is Better

- no permanent AWS access key stored in GitHub
- credentials are temporary
- trust can be restricted by repository and branch
- better credential hygiene
- stronger security model

## Files

- `workflow/ci.yml`
- `iam/github-oidc-trust-policy.json`

## Interview Explanation

> I replaced static AWS credentials with GitHub OIDC federation. GitHub receives a short-lived token and assumes a restricted AWS IAM role through STS.
