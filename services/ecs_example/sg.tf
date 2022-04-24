resource "aws_security_group" "ecs_example" {
  vpc_id      = data.terraform_remote_state.network.outputs.dev_vpc_id
  name        = "${var.service_example}-sg"
  description = "${var.service_example}-sg"

  tags = {
    Name = "${var.service_example}-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ecs_example" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "TCP"
  cidr_blocks       = [data.terraform_remote_state.network.outputs.dev_env.subnet_public_cidr, data.terraform_remote_state.network.outputs.dev_env.subnet_app_cidr]
  security_group_id = aws_security_group.ecs_example.id
  depends_on        = [aws_security_group.ecs_example]
}
