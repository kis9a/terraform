resource "aws_route53_record" "ses_record" {
  zone_id = var.host_zone_id
  name    = "_amazonses.${aws_ses_domain_identity.ses.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses.verification_token]
}

resource "aws_route53_record" "dkim_record" {
  count   = 3
  zone_id = var.host_zone_id
  name    = element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}
