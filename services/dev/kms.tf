resource "aws_kms_key" "service" {
  description             = var.service
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "service" {
  name          = "alias/${var.service}"
  target_key_id = aws_kms_key.service.key_id
}
