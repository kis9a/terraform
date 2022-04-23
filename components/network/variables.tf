variable "service" {
  type    = string
  default = "tf-network"
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "kis9a"
}

variable "prod" {
  type = map(string)
  default = {
    env                = "prod"
    vpc_cidr           = "10.00.0.0/16"
    subnet_public_cidr = "10.00.64.0/20"
    subnet_app_cidr    = "10.00.80.0/20"
    subnet_db_cidr     = "10.00.96.0/20"
  }
}

variable "stg" {
  type = map(string)
  default = {
    env                = "stg"
    vpc_cidr           = "10.10.0.0/16"
    subnet_public_cidr = "10.10.64.0/20"
    subnet_app_cidr    = "10.10.80.0/20"
    subnet_db_cidr     = "10.10.96.0/20"
  }
}

variable "dev" {
  type = map(string)
  default = {
    env                = "dev"
    vpc_cidr           = "10.20.0.0/16"
    subnet_public_cidr = "10.20.64.0/20"
    subnet_app_cidr    = "10.20.80.0/20"
    subnet_db_cidr     = "10.20.96.0/20"
  }
}

variable "prod_availability_zones" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "stg_availability_zones" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "dev_availability_zones" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}
