# kis9a
output "sub_kis9a_tokyo_ssl_arn" {
  value = aws_acm_certificate.tokyo_kis9a_subs.arn
}

output "sub_kis9a_virginia_ssl_arn" {
  value = aws_acm_certificate.virginia_kis9a_subs.arn
}
output "kis9a_tokyo_ssl_arn" {
  value = aws_acm_certificate.tokyo_kis9a.arn
}

output "kis9a_host_zone_id" {
  value = aws_route53_zone.kis9a.zone_id
}

# kis9b
output "domain_kis9b" {
  value = var.domain_kis9b
}

output "sub_kis9b_tokyo_ssl_arn" {
  value = aws_acm_certificate.tokyo_kis9b_subs.arn
}

output "sub_kis9b_virginia_ssl_arn" {
  value = aws_acm_certificate.virginia_kis9b_subs.arn
}

output "kis9b_tokyo_ssl_arn" {
  value = aws_acm_certificate.tokyo_kis9b.arn
}

output "kis9b_host_zone_id" {
  value = aws_route53_zone.kis9b.zone_id
}

# kis9a
output "domain_kis9a" {
  value = var.domain_kis9a
}

output "domain_me_kis9a" {
  value = var.domain_me_kis9a
}

output "domain_ig_kis9a" {
  value = var.domain_ig_kis9a
}
