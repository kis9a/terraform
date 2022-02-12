## admin
resource "aws_iam_group" "admin" {
  name = "${var.service}-admin"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_group_membership" "admin" {
  name       = "${var.service}-admin"
  users      = [aws_iam_user.admin.name, aws_iam_user.admin_tokyo.name, aws_iam_user.kis9a]
  group      = aws_iam_group.admin.name
  depends_on = [aws_iam_group.admin]

  lifecycle {
    prevent_destroy = true
  }
}

## admin mfa
resource "aws_iam_group" "admin_mfa" {
  name = "${var.service}-admin-mfa"

  lifecycle {
    prevent_destroy = true
  }
}

## only tokyo region limitation access
resource "aws_iam_group" "limitation_region_tokyo" {
  name = "${var.service}-limitation-region-tokyo"

  lifecycle {
    prevent_destroy = true
  }
}

## only osaka region limitation access
resource "aws_iam_group" "limitation_region_osaka" {
  name = "${var.service}-limitation-region-osaka"

  lifecycle {
    prevent_destroy = true
  }
}

## readonly
resource "aws_iam_group" "readonly" {
  name = "${var.service}-readonly"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_group_membership" "readonly" {
  name       = "${var.service}-readonly"
  users      = [aws_iam_user.readonly.name]
  group      = aws_iam_group.readonly.name
  depends_on = [aws_iam_group.readonly]

  lifecycle {
    prevent_destroy = true
  }
}
