variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "kis9a"
}

variable "shared_credentials_file" {
  type    = string
  default = "~/.aws/credentials"
}

variable "domain" {
  type = string
  default = "kis9a.com"
}

variable "host_zone_id" {
  type = string
  default = "Z09579232JIYGMEX3JQS5"
}