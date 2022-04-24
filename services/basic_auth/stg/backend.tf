terraform {
  backend "s3" {
    key                    = "terraform-basic-auth-stag.tfstate"
    bucket                 = "kis9a-terraform-states"
    region                 = "ap-northeast-1"
    profile                = "kis9a"
    encrypt                = true
    skip_region_validation = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}
