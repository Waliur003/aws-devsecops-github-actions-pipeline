# Lab 6 — Amazon ECR Delivery

## Goal

Build, scan, version, and push the Docker image to Amazon ECR.

## Image Versioning

```text
<repository>:<github-sha>
```

Each image directly maps to one Git commit.

## Immutable Tags

The ECR repository should use immutable image tags.

The workflow first checks whether the SHA already exists.

```text
Image exists?
   |
 YES -> skip duplicate push
   |
 NO  -> build -> scan -> push
```

This makes reruns safe.

## GitHub Variables

```text
AWS_ROLE_ARN
AWS_REGION
ECR_REPOSITORY
```

## Files

- `workflow/ci.yml`
- `iam/ecr-policy.json`

## Interview Explanation

> Lab 6 adds immutable release artifacts. Every Docker image is tagged with the Git SHA, scanned before upload, and pushed to ECR through OIDC-authenticated GitHub Actions.
