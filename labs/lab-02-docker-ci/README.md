# Lab 2 — Docker CI

## Goal

Containerize the Flask app and validate that the container actually runs.

## Flow

```text
Python Tests
   |
   v
Docker Build
   |
   v
Run Container
   |
   v
GET /health
   |
   v
Cleanup
```

## New Skills

- Dockerfile
- Docker image build
- container naming
- host/container port mapping
- health checks
- container logs
- cleanup in CI

## Health Verification

The pipeline tests:

```text
http://localhost:5000/health
```

Expected:

```json
{"status":"healthy"}
```

## Why This Is Better Than Build-Only CI

A successful `docker build` only proves an image can be created.

This lab proves the application also starts and responds correctly.

## Interview Explanation

> In Lab 2 I containerized the app and added runtime validation. GitHub Actions starts the container, checks the health endpoint, prints logs if something fails, and cleans up the container afterward.
