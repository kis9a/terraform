resource "aws_ecr_repository" "bastion" {
  name = "kis9a/bastion"

  image_scanning_configuration {
    scan_on_push = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
