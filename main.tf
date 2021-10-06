# backend
terraform {
  backend "s3" {
    key                    = "terraform-me.tfstate"
    bucket                 = "kis9a-terraform-states"
    region                 = "ap-northeast-1"
    profile                = "kis9a"
    encrypt                = true
    skip_region_validation = true
  }
}

# provider
provider "aws" {
  profile                = var.aws_profile
  region                 = var.aws_region
  skip_region_validation = true
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "kis9a"
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "domain-kis9b" {
  type    = string
  default = "kis9b.com"
}

resource "aws_route53_zone" "kis9b" {
  name = var.domain-kis9b
}

resource "aws_acm_certificate" "this" {
  domain_name       = "*.${var.domain-kis9b}"
  validation_method = "DNS"
  provider          = aws.virginia
  tags = {
    Name = var.domain-kis9b
  }

  lifecycle {
    create_before_destroy = true
  }
}
