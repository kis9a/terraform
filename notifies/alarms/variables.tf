variable "service" {
  default = "tf-alarms"
}

variable "billing_threshold" {
  default = [10, 30, 50, 100, 300, 500]
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "kis9a"
}
