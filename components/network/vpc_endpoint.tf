resource "aws_vpc_endpoint" "ecr_api" {
  service_name        = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.dev.id
  subnet_ids          = aws_subnet.dev_app.*.id
  security_group_ids  = [aws_security_group.dev_private_link.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr-dkr" {
  service_name        = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.dev.id
  subnet_ids          = aws_subnet.dev_app.*.id
  security_group_ids  = [aws_security_group.dev_private_link.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssm" {
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.dev.id
  subnet_ids          = aws_subnet.dev_app.*.id
  security_group_ids  = [aws_security_group.dev_private_link.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "secretsmanager" {
  service_name        = "com.amazonaws.ap-northeast-1.secretsmanager"
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.dev.id
  subnet_ids          = aws_subnet.dev_app.*.id
  security_group_ids  = [aws_security_group.dev_private_link.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.dev.id
  service_name    = "com.amazonaws.ap-northeast-1.s3"
  route_table_ids = aws_route_table.dev_public.*.id
}
