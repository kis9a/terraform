# backend
terraform {
  backend "s3" {
    key     = "terraform-dot-kis9a.tfstate"
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
  region  = "ap-northeast-1"
  profile = var.aws_profile
}
