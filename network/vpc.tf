resource "aws_vpc" "dev" {
  cidr_block           = var.dev.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "${var.service}-${var.dev.env}"
    Env  = "${var.dev.env}"
  }
}
