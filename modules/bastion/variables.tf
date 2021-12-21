variable "service" {
  type = string
}

variable "env" {
  type = string
}

variable "bastion_instance_type" {
  type = string
}

variable "bastion_instance_image" {
  type = string
}

variable "ssm_iam_instance_profile" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "app_sg" {}
