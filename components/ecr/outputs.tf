output "bastion_arn" {
  value = aws_ecr_repository.bastion.arn
}

output "bastion_repository_url" {
  value = aws_ecr_repository.bastion.repository_url
}
