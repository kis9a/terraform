resource "aws_kms_key" "dev" {
  description             = var.service
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "dev" {
  name          = "alias/dev"
  target_key_id = aws_kms_key.dev.key_id
}
