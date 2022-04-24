resource "aws_security_group" "dev_private_link" {
  vpc_id      = aws_vpc.dev.id
  name        = "${var.service}-${var.dev.env}-private-link"
  description = "${var.service}-${var.dev.env}-private-link"

  tags = {
    Name = "${var.service}-${var.dev.env}-private-link"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
