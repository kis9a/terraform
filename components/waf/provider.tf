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

provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
  profile = var.aws_profile

  default_tags {
    tags = {
      Service = "${var.service}"
    }
  }
}
