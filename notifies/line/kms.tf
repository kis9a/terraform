resource "aws_kms_key" "this" {
  description             = var.service
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.service}"
  target_key_id = aws_kms_key.this.key_id
}

data "aws_kms_secrets" "lambda_secrets" {
  secret {
    name    = "${var.service}_secrets"
    payload = file("${path.module}/secrets.yaml.encrypted")
  }
}

locals {
  lambda_secrets = yamldecode(data.aws_kms_secrets.lambda_secrets.plaintext["${var.service}_secrets"])
}

