resource "aws_cloudwatch_log_group" "bastion" {
  name = "${var.service}-bastion-${var.env}-ssm-cloudwatch"
  tags = {
    Name = "${var.service}-bastion-${var.env}-ssm-cloudwatch"
  }
}

resource "aws_launch_template" "bastion" {
  name                                 = "${var.service}-bastion-${var.env}-template"
  image_id                             = var.bastion_instance_image
  instance_type                        = var.bastion_instance_type
  instance_initiated_shutdown_behavior = "terminate"

  tags = {
    Name = "${var.service}-bastion-${var.env}-template"
  }

  iam_instance_profile {
    name = var.ssm_iam_instance_profile
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    subnet_id                   = var.subnet_public_ids[0]
    security_groups             = [aws_security_group.bastion_ec2.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.service}-bastion-${var.env}"
    }
  }
}

resource "aws_autoscaling_group" "bastion" {
  vpc_zone_identifier       = [var.subnet_public_ids[0]]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  max_size                  = 1
  min_size                  = 1
  termination_policies      = ["OldestInstance"]
  depends_on                = [aws_security_group.bastion_ec2]

  launch_template {
    id      = aws_launch_template.bastion.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_schedule" "bastion_out" {
  scheduled_action_name  = "${var.service}-bastion-${var.env}-scale-out"
  min_size               = 1
  max_size               = 2
  desired_capacity       = 2
  recurrence             = "30 3 * * *"
  time_zone              = "Asia/Tokyo"
  autoscaling_group_name = aws_autoscaling_group.bastion.name
  depends_on             = [aws_autoscaling_group.bastion]
}

resource "aws_autoscaling_schedule" "bastion_in" {
  scheduled_action_name  = "${var.service}-bastion-${var.env}-scale-in"
  min_size               = 1
  max_size               = 1
  desired_capacity       = 1
  recurrence             = "00 4 * * *"
  time_zone              = "Asia/Tokyo"
  autoscaling_group_name = aws_autoscaling_group.bastion.name
  depends_on             = [aws_autoscaling_group.bastion]
}

resource "aws_s3_bucket" "bastion" {
  bucket = "${var.service}-bastion-${var.env}-s3"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "${var.service}-bastion-${var.env}-s3-log"
  }
}

resource "aws_security_group" "bastion_ec2" {
  vpc_id = var.vpc_id
  name   = "${var.service}-bastion-${var.env}-ec2-sg"
  tags = {
    Name = "${var.service}-bastion-${var.env}-ec2-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ssm_document" "bastion" {
  name            = "${var.service}-bastion-${var.env}-ssm-document"
  document_type   = "Session"
  document_format = "JSON"

  content = <<DOC
{
    "schemaVersion": "1.0",
    "description": "${var.service}-bastion-${var.env}-ssm-document",
    "sessionType": "Standard_Stream",
    "inputs": {
        "s3BucketName": "${aws_s3_bucket.bastion.id}",
        "s3EncryptionEnabled": false,
        "cloudWatchLogGroupName": "${aws_cloudwatch_log_group.bastion.name}",
        "cloudWatchEncryptionEnabled": false
    }
}
DOC
}
