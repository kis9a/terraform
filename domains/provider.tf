provider "aws" {
  alias                   = "virginia"
  region                  = "us-east-1"
  profile                 = var.aws_profile
  shared_credentials_file = var.shared_credentials_file
}

provider "aws" {
  alias                   = "tokyo"
  region                  = "ap-northeast-1"
  profile                 = var.aws_profile
  shared_credentials_file = var.shared_credentials_file
}

provider "aws" {
  region                  = var.aws_region
  profile                 = var.aws_profile
  shared_credentials_file = var.shared_credentials_file
  skip_region_validation  = true
}

