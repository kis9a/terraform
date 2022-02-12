terraform {
  backend "s3" {
    key     = "terraform-budgets-kis9a.tfstate"
    bucket  = "kis9a-terraform-states"
    region  = "ap-northeast-1"
    profile = "kis9a"
    encrypt = true
  }
}
