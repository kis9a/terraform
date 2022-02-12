variable "service" {
  type    = string
  default = "service-dev"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "profile" {
  type    = string
  default = "kis9a"
}

variable "ssm_iam_instance_profile" {
  type    = string
  default = "ssm-role-ec2"
}

variable "dev_ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "dev_ec2_instance_image" {
  type    = string
  default = "ami-0df99b3a8349462c6" # ubuntu 20.04
}

variable "dev_ec2_instance_volume_size" {
  type    = string
  default = 16
}

variable "dev_ec2_instance_is_ssm_login" {
  type    = bool
  default = true
}

variable "dev_rds_instance_engine" {
  type    = string
  default = "mysql"
}

variable "dev_rds_instance_engine_version" {
  type    = string
  default = "8.0.27"
}

variable "dev_rds_instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "dev_rds_instance_storage" {
  type    = number
  default = 16
}

variable "dev_rds_instance_max_storage" {
  type    = number
  default = 20
}

variable "dev_rds_instance_db_name" {
  type    = string
  default = "db"
}

variable "dev_rds_instance_user_name" {
  type    = string
  default = "root"
}

variable "dev_scheduler_tag" {
  type = map(string)
  default = {
    key   = "Scheduler"
    value = "service-dev"
  }
}
