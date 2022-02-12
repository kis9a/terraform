## ec2
resource "aws_security_group" "dev_ec2_instance" {
  vpc_id = data.terraform_remote_state.network_dev.outputs.dev_vpc_id
  name   = "${var.service}-instance-sg"
  tags = {
    Name = "${var.service}-instance-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "public" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "TCP"
  cidr_blocks = [
    data.terraform_remote_state.network_dev.outputs.dev_env.subnet_public_cidr,
    data.terraform_remote_state.network_dev.outputs.dev_env.subnet_app_cidr
  ]
  security_group_id = aws_security_group.dev_ec2_instance.id
  depends_on        = [aws_security_group.dev_ec2_instance]
}

## rds
resource "aws_security_group" "dev_rds_instance" {
  vpc_id      = data.terraform_remote_state.network_dev.outputs.dev_vpc_id
  name        = "${var.service}-${var.env}-db-sg"
  description = "${var.service}-${var.env}-db-sg"

  tags = {
    Name = "${var.service}-${var.env}-db-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "dev_rds_instance" {
  type      = "ingress"
  from_port = 3306
  to_port   = 3306
  protocol  = "TCP"
  cidr_blocks = [
    data.terraform_remote_state.network_dev.outputs.dev_env.subnet_public_cidr,
    data.terraform_remote_state.network_dev.outputs.dev_env.subnet_app_cidr,
    data.terraform_remote_state.network_dev.outputs.dev_env.subnet_db_cidr
  ]

  security_group_id = aws_security_group.dev_rds_instance.id
  depends_on        = [aws_security_group.dev_rds_instance]
}
