## admin
resource "aws_iam_group" "admin" {
  name = "${var.service}-admin"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_group_membership" "admin" {
  name       = "${var.service}-admin"
  users      = [aws_iam_user.admin.name, aws_iam_user.admin_tokyo.name]
  group      = aws_iam_group.admin.name
  depends_on = [aws_iam_group.admin]

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
