# backend
terraform {
  backend "s3" {
    key     = "terraform-service-lambda-sls.tfstate"
    bucket  = "kis9a-terraform-states"
    region  = "ap-northeast-1"
    profile = "kis9a"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

provider "aws" {
  alias   = "tokyo"
  region  = var.aws_region
  profile = var.aws_profile
}

data "terraform_remote_state" "domains" {
  backend = "s3"

  config = {
    key     = "terraform-me.tfstate"
    bucket  = "kis9a-terraform-states"
    region  = "ap-northeast-1"
    profile = "kis9a"
    encrypt = true
  }
}
