resource "aws_acm_certificate" "virginia-kis9b-subs" {
  provider          = aws.virginia
  domain_name       = "*.${var.domain-kis9b}"
  validation_method = "DNS"
  tags = {
    Name = var.domain-kis9b
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "tokyo-kis9b-subs" {
  provider          = aws.tokyo
  domain_name       = "*.${var.domain-kis9b}"
  validation_method = "DNS"
  tags = {
    Name = var.domain-kis9b
  }

  lifecycle {
    create_before_destroy = true
  }
}
