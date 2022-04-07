variable "service" {
  type    = string
  default = "tf-iam"
}

variable "ssm_role_ec2" {
  type    = string
  default = "ssm-role-ec2"
}

variable "region_limitation_actions" {
  type = list(string)
  default = [
    "ec2:*",
    "rds:*",
    "redshift:*",
    "ecs:*",
    "lambda:*",
    "dynamodb:*",
    "apigateway:*",
    "batch:*",
    "workspaces:*",
    "glue:*"
  ]
}
