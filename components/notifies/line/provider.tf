provider "aws" {
  profile                = var.aws_profile
  region                 = var.aws_region
  skip_region_validation = true
}
