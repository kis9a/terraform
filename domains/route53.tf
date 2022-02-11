resource "aws_route53_zone" "kis9b" {
  name = var.domain_kis9b
}

resource "aws_route53_zone" "kis9a" {
  name = var.domain_kis9a
}
