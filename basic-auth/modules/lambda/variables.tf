variable "service" {
  type = string
}

variable "env" {
  type = string
}

variable "lambda_role_arn" {
  type = string
}

variable "basic_auth_credentials" {
  type        = map(any)
  description = "Credentials for Basic Authentication. Pass a map composed of 'user' and 'password'."
}
