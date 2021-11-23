terraform {
  backend "s3" {
    key     = "terraform-me.tfstate"
    bucket  = "kis9a-terraform-states"
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
  region                  = var.aws_region
  profile                 = var.aws_profile
  shared_credentials_file = var.shared_credentials_file
  skip_region_validation  = true
}

provider "aws" {
  alias                   = "virginia"
  region                  = "us-east-1"
  profile                 = var.aws_profile
  shared_credentials_file = var.shared_credentials_file
}

provider "aws" {
  alias                   = "tokyo"
  region                  = "ap-northeast-1"
  profile                 = var.aws_profile
  shared_credentials_file = var.shared_credentials_file
}

variable "shared_credentials_file" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "domain-kis9b" {
  type    = string
  default = "kis9b.com"
}

resource "aws_route53_zone" "kis9b" {
  name = var.domain-kis9b
}

resource "aws_acm_certificate" "virginia-kis9b-subs" {
  provider          = aws.virginia
  domain_name       = "*.${var.domain-kis9b}"
  validation_method = "DNS"
  tags = {
    Name = var.domain-kis9b
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "tokyo-kis9b-subs" {
  provider          = aws.tokyo
  domain_name       = "*.${var.domain-kis9b}"
  validation_method = "DNS"
  tags = {
    Name = var.domain-kis9b
  }

  lifecycle {
    create_before_destroy = true
  }
}
