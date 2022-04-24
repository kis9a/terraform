data "aws_caller_identity" "self" {}

locals {
  container_definitions_json = jsonencode([
    {
      command    = ["./server"],
      entryPoint = null,
      essential  = true,
      image      = "${data.aws_caller_identity.self.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/kis9a/mock-server-go-docker:v1.0",
      name       = var.container_name,
      portMappings = [
        {
          containerPort = "${var.container_port}",
          hostPort      = "${var.container_port}",
          protocol      = "tcp"
        }
      ],
      environment = [
        {
          name  = "SERVER_PORT",
          value = tostring("${var.container_port}")
        }
      ],
    }
  ])
}

resource "aws_ecs_task_definition" "mock" {
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  family                   = var.family_name
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn
  container_definitions    = local.container_definitions_json
}
