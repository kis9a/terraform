resource "aws_route53_zone" "kis9b" {
  name = var.domain_kis9b
}

resource "aws_route53_zone" "kis9a" {
  name = var.domain_kis9a
}

resource "aws_route53_record" "txt_orero" {
  zone_id = aws_route53_zone.kis9a.id
  name    = "oro.${var.domain_kis9a}"
  type    = "TXT"
  ttl     = "60"
  records = [base64encode(file("${path.module}/oro"))]
}
