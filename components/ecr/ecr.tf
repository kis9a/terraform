resource "aws_ecr_repository" "mock_server_go_docker" {
  name = "kis9a/mock-server-go-docker"

  image_scanning_configuration {
    scan_on_push = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ecr_lifecycle_policy" "mock_server_go_docker" {
  repository = aws_ecr_repository.mock_server_go_docker.name
  policy     = local.lifecycle_policy_expire_more_than_rules
}

# lifecycle
locals {
  lifecycle_policy_expire_more_than_rules = jsonencode({
    rules = [
      {
        rulePriority = 10,
        description  = "Expire images count more than 10 untagged",
        selection = {
          tagStatus   = "untagged",
          countType   = "imageCountMoreThan",
          countNumber = 10
        },
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 20,
        description  = "Expire images count more than 14 tagged",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 14
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}
