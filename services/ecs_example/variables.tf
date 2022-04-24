variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "kis9a"
}

variable "service" {
  type    = string
  default = "kis9a-ecr"
}

variable "service_example" {
  type    = string
  default = "ecs-example"
}
