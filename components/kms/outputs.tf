output "dev_key_arn" {
  value = aws_kms_key.dev.arn
}

output "dev_key_id" {
  value = aws_kms_key.dev.key_id
}

output "dev_alias" {
  value = aws_kms_alias.dev.arn
}
