terraform {
  backend "s3" {
    bucket       = "waliur003-devsecops-terraform-state-418272769771"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}