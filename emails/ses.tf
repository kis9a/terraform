resource "aws_ses_domain_identity" "ses" {
  provider = aws.virginia
  domain   = var.domain

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ses_domain_dkim" "dkim" {
  provider = aws.virginia
  domain   = aws_ses_domain_identity.ses.domain

  lifecycle {
    prevent_destroy = true
  }
}
