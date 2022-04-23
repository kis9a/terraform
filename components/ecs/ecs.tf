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

# resource "aws_ecs_task_definition" "app" {
#   family        = "${var.service}-task-definition"
#   task_role_arn = aws_iam_role.ecs_task.arn
#   network_mode  = "awsvpc"
#   requires_compatibilities = [
#     "FARGATE"
#   ]
#   execution_role_arn = aws_iam_role.bastion_task_exec_role.arn
#   memory             = "512"
#   cpu                = "256"
#   container_definitions = templatefile(
#     "${path.module}/taskdef/bastion.json",
#     {
#       IMAGE_PREFIX      = "${var.ecr_base_uri}/${var.tags.Project}"
#       BASTION_LOG_GROUP = aws_cloudwatch_log_group.bastion.name
#       REGION            = var.region
#     }
#   )
# }
