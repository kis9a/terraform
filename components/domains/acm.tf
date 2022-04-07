## kis9a
resource "aws_acm_certificate" "virginia_kis9a" {
  provider          = aws.virginia
  domain_name       = var.domain_kis9a
  validation_method = "DNS"
  tags = {
    Name = var.domain_kis9a
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "virginia_kis9a_subs" {
  provider          = aws.virginia
  domain_name       = "*.${var.domain_kis9a}"
  validation_method = "DNS"
  tags = {
    Name = var.domain_kis9a
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "tokyo_kis9a" {
  provider          = aws.tokyo
  domain_name       = var.domain_kis9a
  validation_method = "DNS"
  tags = {
    Name = var.domain_kis9a
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "tokyo_kis9a_subs" {
  provider          = aws.tokyo
  domain_name       = "*.${var.domain_kis9a}"
  validation_method = "DNS"
  tags = {
    Name = var.domain_kis9a
  }

  lifecycle {
    create_before_destroy = true
  }
}

## kis9b
resource "aws_acm_certificate" "virginia_kis9b" {
  provider          = aws.virginia
  domain_name       = var.domain_kis9b
  validation_method = "DNS"
  tags = {
    Name = var.domain_kis9b
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "virginia_kis9b_subs" {
  provider          = aws.virginia
  domain_name       = "*.${var.domain_kis9b}"
  validation_method = "DNS"
  tags = {
    Name = var.domain_kis9b
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "tokyo_kis9b_subs" {
  provider          = aws.tokyo
  domain_name       = "*.${var.domain_kis9b}"
  validation_method = "DNS"
  tags = {
    Name = var.domain_kis9b
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "tokyo_kis9b" {
  provider          = aws.tokyo
  domain_name       = var.domain_kis9b
  validation_method = "DNS"
  tags = {
    Name = var.domain_kis9b
  }

  lifecycle {
    create_before_destroy = true
  }
}
