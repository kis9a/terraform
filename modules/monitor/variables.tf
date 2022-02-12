variable "env" {
  type = string
}

variable "service" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_app_cidr" {
  type = string
}

variable "subnet_public_cidr" {
  type = string
}

variable "subnet_app_id" {
  type = string
}

variable "monitor_instance_image" {
  type = string
}

variable "monitor_instance_type" {
  type = string
}

variable "is_ssm_login" {
  type = bool
}

variable "ssm_iam_instance_profile" {
  type = string
}
