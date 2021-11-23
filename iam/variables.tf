variable "service" {
  type    = string
  default = "tf-iam"
}

variable "shared_credentials_file" {
  type    = string
  default = "~/.aws/credentials"
}
