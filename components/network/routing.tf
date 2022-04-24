# dev
resource "aws_internet_gateway" "dev_gw" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "${var.service}-${var.dev.env}"
  }
}

resource "aws_route_table" "dev_public" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_gw.id
  }

  tags = {
    Name = "${var.service}-${var.dev.env}"
  }
}

## nat gateway is expensive, db, app subnet is public, when development environment.
# resource "aws_route_table" "dev_private" {
#   count  = 2
#   vpc_id = aws_vpc.dev.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = element(aws_nat_gateway.dev.*.id, count.index)
#   }

#   tags = {
#     Name = "${var.service}-${var.dev.env}"
#   }
# }

resource "aws_route_table_association" "dev_public_route_table" {
  count          = 2
  route_table_id = aws_route_table.dev_public.id
  subnet_id      = element(aws_subnet.dev_public.*.id, count.index)
}

resource "aws_route_table_association" "app_route_table" {
  count          = 2
  route_table_id = element(aws_route_table.dev_public.*.id, count.index)
  subnet_id      = element(aws_subnet.dev_app.*.id, count.index)
}

resource "aws_route_table_association" "db_route_table" {
  count          = 2
  route_table_id = element(aws_route_table.dev_public.*.id, count.index)
  subnet_id      = element(aws_subnet.dev_db.*.id, count.index)
}
