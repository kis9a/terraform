data "aws_kms_secrets" "secrets" {
  secret {
    name    = "secrets"
    payload = file("${path.module}/secrets.yaml.encrypted")
  }
}

locals {
  s = yamldecode(data.aws_kms_secrets.secrets.plaintext["secrets"])
}

resource "aws_db_subnet_group" "dev" {
  name       = "${var.service}-rds-subnet"
  subnet_ids = data.terraform_remote_state.network_dev.outputs.dev_subnet_db_ids
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_parameter_group" "dev" {
  name   = "${var.service}-rds-pg"
  family = "mysql8.0"

  parameter {
    name  = "general_log"
    value = "0"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "max_connections"
    value = "1000"
  }

  parameter {
    name  = "wait_timeout"
    value = "60"
  }

  parameter {
    name  = "long_query_time"
    value = "3"
  }
}

resource "aws_db_option_group" "dev" {
  name                 = "${var.service}-rds"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}

resource "aws_db_instance" "dev" {
  name                            = "dev"
  identifier                      = "${var.service}-instance"
  tags                            = var.dev_scheduler_tag_resource
  engine                          = var.dev_rds_instance_engine
  engine_version                  = var.dev_rds_instance_engine_version
  instance_class                  = var.dev_rds_instance_class
  parameter_group_name            = aws_db_parameter_group.dev.name
  option_group_name               = aws_db_option_group.dev.name
  db_subnet_group_name            = aws_db_subnet_group.dev.name
  allocated_storage               = var.dev_rds_instance_storage
  max_allocated_storage           = var.dev_rds_instance_max_storage
  vpc_security_group_ids          = [aws_security_group.dev_rds_instance.id]
  enabled_cloudwatch_logs_exports = ["audit", "error", "general"]
  username                        = var.dev_rds_instance_user_name
  password                        = local.s.db_password_root
  publicly_accessible             = true
  skip_final_snapshot             = true
}
