resource "aws_iam_role" "ssm_role" {
  name = "${var.service}-ec2-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = "${var.service}-ec2-ssm-role"
  }
}

resource "aws_iam_role" "chatbot" {
  name = "${var.service}-chatbot-notification-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "chatbot.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role" "lambda_edge_role" {
  name = "${var.service}-basic-lambda-edge-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = [
            "lambda.amazonaws.com",
            "edgelambda.amazonaws.com"
          ],
        },
      }
    ]
  })
}

resource "aws_iam_role" "tf_plan" {
  name = "${var.service}-tf-plan-role"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "codebuild.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    aws_iam_policy.tf_plan.arn
  ]
}

data "aws_iam_policy_document" "ssm_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ssm_role_ec2" {
  name               = var.ssm_role_ec2
  assume_role_policy = data.aws_iam_policy_document.ssm_role.json

  tags = {
    Name = "${var.service}"
  }
}

resource "aws_iam_instance_profile" "ssm_role_ec2" {
  name = var.ssm_role_ec2
  role = aws_iam_role.ssm_role_ec2.name

  tags = {
    Name = "${var.service}-ssm-role-ec2"
  }
}

resource "aws_iam_role" "bastion_task_exec_role" {
  name = "${var.prefix}-bastion-task-execution"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = {
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }
  })
}

resource "aws_iam_role_policy" "ecs_exec" {
  name = "${var.prefix}-ecs-task"
  role = aws_iam_role.bastion_task_exec_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}
