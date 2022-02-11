terraform {
  backend "s3" {
    key     = "terraform-me.tfstate"
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
