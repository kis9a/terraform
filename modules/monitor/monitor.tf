resource "aws_instance" "monitor" {
  count                  = 1
  subnet_id              = var.subnet_app_id
  ami                    = var.monitor_instance_image
  key_name               = "${var.service}-${var.env}"
  instance_type          = var.monitor_instance_type
  vpc_security_group_ids = [aws_security_group.monitor_ec2.id]
  iam_instance_profile   = var.is_ssm_login ? var.ssm_iam_instance_profile : null

  tags = {
    Name = "${var.service}-monitor-${var.env}"
  }
}

resource "aws_security_group" "monitor_ec2" {
  vpc_id = var.vpc_id
  name   = "${var.service}-monitor-${var.env}-ec2-sg"
  tags = {
    Name = "${var.service}-monitor-${var.env}-ec2-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "bastion_to_app_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = [var.subnet_public_cidr, var.subnet_app_cidr]
  security_group_id = aws_security_group.monitor_ec2.id
}
