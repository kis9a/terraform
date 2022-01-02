resource "aws_subnet" "dev_public" {
  count             = 2
  vpc_id            = aws_vpc.dev.id
  availability_zone = var.dev_availability_zones[count.index]
  cidr_block        = cidrsubnet(var.dev.subnet_public_cidr, 4, count.index)

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "${var.service}-${var.dev.env}-public-${var.dev_availability_zones[count.index]}"
    Env  = "${var.dev.env}"
  }
}

resource "aws_subnet" "dev_app" {
  count             = 2
  vpc_id            = aws_vpc.dev.id
  availability_zone = var.dev_availability_zones[count.index]
  cidr_block        = cidrsubnet(var.dev.subnet_app_cidr, 4, count.index)

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "${var.service}-${var.dev.env}-app-${var.dev_availability_zones[count.index]}"
    Env  = "${var.dev.env}"
  }
}

resource "aws_subnet" "dev_db" {
  count             = 2
  vpc_id            = aws_vpc.dev.id
  availability_zone = var.dev_availability_zones[count.index]
  cidr_block        = cidrsubnet(var.dev.subnet_db_cidr, 4, count.index)

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "${var.service}-${var.dev.env}-db-${var.dev_availability_zones[count.index]}"
    Env  = "${var.dev.env}"
  }
}
