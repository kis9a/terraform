variable "service" {
  type    = string
  default = "aws-cost-line-notify"
}

variable "service_tags" {
  type = map(string)
  default = {
    Name = "aws-cost-line-notify"
  }
}

variable "aws_profile" {
  type    = string
  default = "kis9a"
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "schedule_expression" {
  type    = string
  default = "cron(0 15 * * ? *)"
}
