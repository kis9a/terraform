variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "kis9a"
}

variable "service" {
  type    = string
  default = "bastion"
}

variable "ssm_log" {
  type    = string
  default = "bastion-ssm-log"
}

variable "tags" {
  type = map(string)
  default = {
    Name = "bastion"
  }
}

variable "bastion_instance_type" {
  type    = string
  default = "t3.nano"
}

variable "bastion_instance_image" {
  type    = string
  default = "ami-0df99b3a8349462c6" # ubuntu 20.04
}

variable "monitor_instance_type" {
  type    = string
  default = "t3.nano"
}

variable "monitor_instance_image" {
  type    = string
  default = "ami-0df99b3a8349462c6" # ubuntu 20.04
}

variable "ssm_iam_instance_profile" {
  type    = string
  default = "ssm-role-ec2"
}

variable "env" {
  type    = string
  default = "dev"
}
