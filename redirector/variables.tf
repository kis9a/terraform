variable "aws_profile" {
  type    = string
  default = "kis9a"
}

variable "host_zone_id" {
  type = map(string)
  default = {
    kis9a = "Z09579232JIYGMEX3JQS5"
  }
}

variable "fqdn" {
  type = map(string)
  default = {
    dot_kis9a  = "dot.kis9a.com"
    zenn_kis9a = "zenn.kis9a.com"
  }
}

variable "redirect_target" {
  type = map(string)
  default = {
    dot_kis9a  = "https://github.com/kis9a/dotfiles"
    zenn_kis9a = "https://zenn.dev/kis9a"
  }
}

variable "force_destroy" {
  type = map(bool)
  default = {
    is = true
    no = false
  }
}

variable "ssl_certificate_arn" {
  type = map(string)
  default = {
    sub_kis9a = "arn:aws:acm:us-east-1:298276046670:certificate/55c5ce44-b780-45ea-b5b2-c550cdcde710"
  }
}

variable "dot_kis9a_tags" {
  type        = map(string)
  description = "Tags"
  default = {
    Name = "dot.kis9a.redirector"
  }
}

variable "zenn_kis9a_tags" {
  type        = map(string)
  description = "Tags"
  default = {
    Name = "zenn.kis9a.redirector"
  }
}
