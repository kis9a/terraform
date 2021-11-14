# provider
provider "aws" {
  profile = "kis9a"
  region  = "ap-northeast-1"
}

provider "aws" {
  alias   = "cloudfront"
  profile = "kis9a"
  region  = "ap-northeast-1"
}
