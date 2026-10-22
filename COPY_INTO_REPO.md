# Copy These Labs Into Your Existing GitHub Repository

## Windows PowerShell

From the folder containing this package:

```powershell
Copy-Item -Recurse -Force .\labs <PATH-TO-YOUR-REPO>\
Copy-Item -Force .\README.md <PATH-TO-YOUR-REPO>\README-LABS.md
Copy-Item -Force .\SETUP.md <PATH-TO-YOUR-REPO>\SETUP.md
```

Then:

```powershell
cd <PATH-TO-YOUR-REPO>
git add .
git commit -m "docs: add Lab 1 to Lab 8 learning archive"
git push
```

## Recommended

Keep your current root README if you already like it.

Use this package's `README.md` as either:

```text
README-LABS.md
```

or merge its Lab Roadmap section into your root README.

## Important

Before deploying any Lab 7/8 Terraform code, replace placeholders:

```text
<YOUR_ACCOUNT_ID>
<YOUR_TERRAFORM_STATE_BUCKET>
<YOUR_GITHUB_USER>
<YOUR_REPOSITORY>
<YOUR_ECR_REPOSITORY>
<REGION>
```
