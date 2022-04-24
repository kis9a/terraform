# This is memo when I applyed ecs service at first.
resource "aws_ecs_task_definition" "example" {
  family                   = var.service_example
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.example_webserver.rendered
  execution_role_arn       = data.terraform_remote_state.iam.outputs.iam_role_ecs_task_execution_role.arn
  task_role_arn            = data.terraform_remote_state.iam.outputs.iam_role_ecs_task_role.arn
}

data "template_file" "example_webserver" {
  template = file(
    "taskdef/example_webserver.json",
  )

  vars = {
    ECR_ACCOUNT_URL = "${data.aws_caller_identity.self.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com"
  }
}

data "aws_ecs_task_definition" "example" {
  task_definition = aws_ecs_task_definition.example.family
}

resource "aws_ecs_service" "example" {
  name                    = var.service_example
  cluster                 = data.terraform_remote_state.ecs.outputs.cluster_dev.name
  task_definition         = "${aws_ecs_task_definition.example.family}:${max("${aws_ecs_task_definition.example.revision}", "${data.aws_ecs_task_definition.example.revision}")}"
  launch_type             = "FARGATE"
  desired_count           = 1
  enable_ecs_managed_tags = true
  # health_check_grace_period_seconds = 2

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_example.id]
    subnets          = data.terraform_remote_state.network.outputs.dev_subnet_app_ids
  }

  # load_balancer {
  #   target_group_arn = var.example_ecs_target_group
  #   container_name   = "${var.service_example}-app"
  #   container_port   = 8080
  # }

  lifecycle {
    ignore_changes = [
      # task_definition,
      # load_balancer,
    ]
  }
}
