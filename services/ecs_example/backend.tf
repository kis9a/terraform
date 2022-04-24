terraform {
  backend "s3" {
    key     = "terraform-ecs-example.tfstate"
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

data "aws_caller_identity" "self" {}

data "terraform_remote_state" "ecs" {
  backend = "s3"

  config = {
    key     = "terraform-ecs.tfstate"
    bucket  = "kis9a-terraform-states"
    region  = "ap-northeast-1"
    profile = "kis9a"
    encrypt = true
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"

  config = {
    key     = "terraform-iam-kis9a.tfstate"
    bucket  = "kis9a-terraform-states"
    region  = "ap-northeast-1"
    profile = "kis9a"
    encrypt = true
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    key     = "terraform-network-kis9a.tfstate"
    bucket  = "kis9a-terraform-states"
    region  = "ap-northeast-1"
    profile = "kis9a"
    encrypt = true
  }
}
