variable "service" {
  type = string
}

variable "service_tags" {
  type = map(string)
}

variable "redirect_target" {
  type = string
}

variable "lambda_function_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "schedule_expression" {
  type = string
}
