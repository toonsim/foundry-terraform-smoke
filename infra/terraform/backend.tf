terraform {
  backend "s3" {
    bucket         = "foundry-tfstate-273613910635-eu-west-1-foundry-terraform-smoke"
    key            = "foundry-terraform-smoke/terraform.tfstate"
    region         = "eu-west-1"
    use_lockfile   = true
    encrypt        = true
    allowed_account_ids = ["273613910635"]
  }
}
