provider "aws" {
  profile = "kis9a"
  region  = "ap-northeast-1"

  default_tags {
    tags = {
      Service = "${var.service}"
    }
  }
}
