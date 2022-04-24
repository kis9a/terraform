variable "container_port" {
  type = number
}

variable "container_name" {
  type = string
}

variable "family_name" {
  type = string
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "ecs_task_role_arn" {
  type = string
}

variable "ecs_task_execution_role_arn" {
  type = string
}
