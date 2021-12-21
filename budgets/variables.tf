variable "account_name" {
  type = string
  default = "kis9a"
}

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

variable "subscriber_emails" {
  type = list(string)
  default = ["kis9ax@gmail.com"]
}
