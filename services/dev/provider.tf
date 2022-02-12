provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Name    = "${var.service}"
      Service = "${var.service}"
      Env     = "${var.env}"
    }
  }
}
