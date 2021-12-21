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

data "aws_kms_secrets" "this" {
  secret {
    name    = "line_token"
    payload = file("${path.module}/line_token.yaml.encrypted")
  }
}

locals {
  line_token = yamldecode(data.aws_kms_secrets.this.plaintext["line_token"])
}
