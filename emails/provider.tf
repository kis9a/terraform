provider "aws" {
  region                  = var.aws_region
  profile                 = var.aws_profile
}

provider "aws" {
  alias                   = "virginia"
  region                  = "us-east-1"
  profile                 = var.aws_profile
}
