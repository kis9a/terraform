resource "aws_iam_user" "admin" {
  name = "${var.service}-admin"
  tags = {
    Name = "${var.service}-admin"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user" "admin_tokyo" {
  name = "${var.service}-admin-tokyo"
  tags = {
    Name = "${var.service}-admin-tokyo"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user" "maintainer" {
  name = "${var.service}-maintainer"
  tags = {
    Name = "${var.service}-maintainer"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user" "readonly" {
  name = "${var.service}-readonly"
  tags = {
    Name = "${var.service}-readonly"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user" "ecs_deploy" {
  name = "${var.service}-ecs-deploy"
  tags = {
    Name = "${var.service}-ecs-deploy"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user" "frontend" {
  name = "${var.service}-frontend"
  tags = {
    Name = "${var.service}-frontend"
  }

  lifecycle {
    prevent_destroy = true
  }
}
