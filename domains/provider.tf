provider "aws" {
  alias                   = "virginia"
  region                  = "us-east-1"
  profile                 = var.aws_profile
}

provider "aws" {
  alias                   = "tokyo"
  region                  = "ap-northeast-1"
  profile                 = var.aws_profile
}

provider "aws" {
  region                  = var.aws_region
  profile                 = var.aws_profile
  skip_region_validation  = true
}
