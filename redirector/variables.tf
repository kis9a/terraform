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
    me_kis9a   = "me.kis9a.com"
    dot_kis9a  = "dot.kis9a.com"
    tf_kis9a   = "tf.kis9a.com"
    zenn_kis9a = "zenn.kis9a.com"
    gh_kis9a   = "gh.kis9a.com"
    tw_kis9a   = "tw.kis9a.com"
  }
}

variable "redirect_target" {
  type = map(string)
  default = {
    me_kis9a   = "https://github.com/kis9a/kis9a"
    dot_kis9a  = "https://github.com/kis9a/dotfiles"
    tf_kis9a   = "https://github.com/kis9a/terraform"
    zenn_kis9a = "https://zenn.dev/kis9a"
    gh_kis9a   = "https://github.com/kis9a"
    tw_kis9a   = "https://twitter.com/kis9a"
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

variable "tags" {
  type = map(map(string))
  default = {
    me = {
      Name = "me.kis9a.redirector"
    }
    dot = {
      Name = "dot.kis9a.redirector"
    }
    zenn = {
      Name = "zenn.kis9a.redirector"
    }
    tf = {
      Name = "tf.kis9a.redirector"
    }
    gh = {
      Name = "gh.kis9a.redirector"
    }
    tw = {
      Name = "tw.kis9a.redirector"
    }
  }
}
