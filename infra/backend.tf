terraform {
  backend "s3" {
    bucket  = "etl-serverless-sre-terraform-state"
    key     = "etl-serverless-sre/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
