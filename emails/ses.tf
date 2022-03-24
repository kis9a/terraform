resource "aws_ses_domain_identity" "ses" {
  provider = aws.virginia
  domain   = data.terraform_remote_state.domains.outputs.domain_kis9a
}

resource "aws_ses_domain_dkim" "dkim" {
  provider = aws.virginia
  domain   = aws_ses_domain_identity.ses.domain
}

resource "aws_ses_domain_mail_from" "ses" {
  provider = aws.virginia
  domain           = aws_ses_domain_identity.ses.domain
  mail_from_domain = "mail.${aws_ses_domain_identity.ses.domain}"
  depends_on       = [aws_ses_domain_identity.ses]
}

resource "aws_ses_domain_identity" "ses_tokyo" {
  domain   = data.terraform_remote_state.domains.outputs.domain_kis9a
}

resource "aws_ses_domain_dkim" "dkim_tokyo" {
  domain   = aws_ses_domain_identity.ses_tokyo.domain
}

resource "aws_ses_domain_mail_from" "ses_tokyo" {
  domain           = aws_ses_domain_identity.ses_tokyo.domain
  mail_from_domain = "mail.${aws_ses_domain_identity.ses_tokyo.domain}"
  depends_on       = [aws_ses_domain_identity.ses_tokyo]
}
