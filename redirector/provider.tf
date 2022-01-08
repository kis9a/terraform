provider "aws" {
  profile = var.aws_profile
  region  = "ap-northeast-1"
  shared_credentials_file = var.shared_credentials_file
}
