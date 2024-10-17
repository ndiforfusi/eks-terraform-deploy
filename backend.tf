terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "infra/terraform.state"
    bucket         = "groupa-buck-diraine"
    region         = "us-west-2"
    dynamodb_table = "terraform-state-locking"
  }
}
