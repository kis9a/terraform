resource "aws_route53_record" "ses_record" {
  zone_id = data.terraform_remote_state.domains.outputs.kis9a_host_zone_id
  name    = "_amazonses.${aws_ses_domain_identity.ses.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses.verification_token]
}

resource "aws_route53_record" "dkim_record" {
  count   = 3
  zone_id = data.terraform_remote_state.domains.outputs.kis9a_host_zone_id
  name    = element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "ses_mail_from_txt" {
  zone_id = data.terraform_remote_state.domains.outputs.kis9a_host_zone_id
  name    = aws_ses_domain_mail_from.ses.mail_from_domain
  type    = "TXT"
  ttl     = "60"
  records = ["v=spf1 include:amazonses.com ~all"]
}

resource "aws_route53_record" "ses_mail_from_mx" {
  zone_id = data.terraform_remote_state.domains.outputs.kis9a_host_zone_id
  name    = aws_ses_domain_mail_from.ses.mail_from_domain
  type    = "MX"
  ttl     = "60"
  records = ["14 feedback-smtp.ap-northeast-1.amazonses.com"]
}

resource "aws_route53_record" "dkim_record_tokyo" {
  count   = 3
  zone_id = data.terraform_remote_state.domains.outputs.kis9a_host_zone_id
  name    = element(aws_ses_domain_dkim.dkim_tokyo.dkim_tokens, count.index)
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.dkim_tokyo.dkim_tokens, count.index)}.dkim.amazonses.com"]
}
