resource "aws_iam_user" "frontend" {
  name = "${var.service}-frontend"
  tags = {
    Name = "${var.service}-frontend"
  }

  lifecycle {
    prevent_destroy = true
  }
}
