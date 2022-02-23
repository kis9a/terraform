variable "aws_profile" {
  type    = string
  default = "kis9a"
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "ecr_tag_name" {
  type    = string
  default = "latest"
}

variable "service" {
  type    = string
  default = "lambda-sls"
}

variable "api_domain" {
  type    = string
  default = "sls.kis9a.com"
}

variable "binary_media_types" {
  type    = list(string)
  default = ["*/*"]
}

variable "stage_name" {
  type    = string
  default = "main"
}
