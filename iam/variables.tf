variable "service" {
  type    = string
  default = "tf-iam"
}

variable "shared_credentials_file" {
  type    = string
  default = "~/.aws/credentials"
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
