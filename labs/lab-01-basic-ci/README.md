# Lab 1 — Basic Python CI

## Goal

Create the first CI pipeline.

Every push or pull request to `main` should:

1. Check out the repository.
2. Install Python 3.12.
3. Install application dependencies.
4. Run pytest.

## Architecture

```text
Developer
   |
   v
Git Push / Pull Request
   |
   v
GitHub Actions
   |
   v
Python Setup
   |
   v
pip install
   |
   v
pytest
```

## Main File

```text
.github/workflows/ci.yml
```

Use the workflow saved in:

```text
workflow/ci.yml
```

## What You Learn

- CI fundamentals
- GitHub Actions YAML
- triggers
- jobs and steps
- runners
- automated tests
- build failure gates

## Verification

Push a commit.

Expected:

```text
Python Tests ✅
```

Then intentionally break a test and push again.

Expected:

```text
Python Tests ❌
```

This proves CI is enforcing code quality.

## Interview Explanation

> I started the project with a basic CI workflow. Every push and pull request automatically installs dependencies and runs Flask unit tests so broken code cannot move to later pipeline stages.
