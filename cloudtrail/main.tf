terraform {
  backend "s3" {
    key     = "terraform-cloudtrail.tfstate"
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

variable "shared_credentials_file" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "service" {
  type    = string
  default = "cloudtrail"
}

resource "aws_cloudtrail" "this" {
  name                          = var.service
  s3_bucket_name                = aws_s3_bucket.this.id
  include_global_service_events = false
}

data "aws_caller_identity" "this" {}

resource "aws_s3_bucket" "this" {
  bucket        = "kis9a-${var.service}"
  force_destroy = true
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSCloudTrailAclCheck"
        Action = "s3:PutObject"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Resource = [
          "arn:aws:s3:::kis9a-${var.service}"
        ]
      },
      {
        Sid    = "AWSCloudTrailWrite"
        Action = "s3:PutObject"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Resource = [
          "arn:aws:s3:::kis9a-${var.service}/AWSLogs/${data.aws_caller_identity.this.account_id}",
          "arn:aws:s3:::kis9a-${var.service}/AWSLogs/${data.aws_caller_identity.this.account_id}/*"
        ]
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
