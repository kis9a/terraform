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

resource "aws_route53_record" "keybase_nav_kis9a_proof_of_identify" {
  zone_id = aws_route53_zone.kis9a.id
  name    = "nav.${var.domain_kis9a}"
  type    = "TXT"
  ttl     = "60"
  records = ["keybase-site-verification=sPrCeSQdd8ZXWenCe21Lc3Wb5UGwGSQcq1DV_-5XLfw"]
}
