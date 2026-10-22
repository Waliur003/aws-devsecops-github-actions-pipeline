terraform {
  backend "s3" {
    bucket       = "<YOUR_TERRAFORM_STATE_BUCKET>"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
