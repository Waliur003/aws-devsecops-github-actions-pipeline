# Lab 3 — Trivy Security Scanning

## Goal

Add repository and container security scanning.

## Flow

```text
Source Code
   |
   v
Trivy Filesystem Scan
   |
   v
Docker Build
   |
   v
Trivy Image Scan
   |
   v
HIGH / CRITICAL Security Gate
```

## Repository Scan

Checks for:

- vulnerable dependencies
- secrets
- risky files

## Image Scan

Checks installed packages inside the built container.

## Security Gate

The enforcement scan uses:

```yaml
severity: HIGH,CRITICAL
ignore-unfixed: true
exit-code: 1
```

If policy fails, deployment stops.

## Artifact

A JSON report is uploaded so findings can be reviewed later.

## DevSecOps Principle

Security becomes part of CI rather than a separate after-deployment activity.

## Interview Explanation

> I used Trivy twice: first against the repository and then against the built container. HIGH and CRITICAL findings become blocking CI gates.
