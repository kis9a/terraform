provider "aws" {
  region                 = var.aws_region
  profile                = var.aws_profile
  skip_region_validation = true

  default_tags {
    tags = {
      Service = "${var.service}"
    }
  }
}
