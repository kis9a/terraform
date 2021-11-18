variable "host_zone_id" {
  type    = string
  default = "Z09579232JIYGMEX3JQS5"
}

variable "fqdn" {
  type    = string
  default = "dot.kis9a.com"
}

variable "redirect_target" {
  type    = string
  default = "https://github.com/kis9a/dotfiles"
}

variable "force_destroy" {
  type    = string
  default = "false"
}

variable "ssl_certificate_arn" {
  type    = string
  default = "arn:aws:acm:us-east-1:298276046670:certificate/55c5ce44-b780-45ea-b5b2-c550cdcde710"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default = {
    Name = "dot.kis9a.redirector"
  }
}
