provider "aws" {
  profile                 = var.aws_profile
  region                  = var.aws_region
  shared_credentials_file = var.shared_credentials_file
  skip_region_validation  = true
}
