# dev
output "dev_vpc_id" {
  value = aws_vpc.dev.id
}

output "dev_subnet_app_ids" {
  value = aws_subnet.dev_app.*.id
}

output "dev_subnet_public_ids" {
  value = aws_subnet.dev_public.*.id
}

output "dev_subnet_db_ids" {
  value = aws_subnet.dev_db.*.id
}

output "dev_env" {
  value = var.dev
}

output "dev_availability_zones" {
  value = var.dev_availability_zones
}
