resource "aws_ecs_cluster" "dev" {
  name = "${var.service}-dev"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.service}-dev-ecs"
  }
}
