module "kms" {
  source  = "../modules/kms"
  env     = var.env
  service = var.service
}

data "aws_kms_secrets" "basic_auth_secrets" {
  secret {
    name    = "${var.service}_secrets"
    payload = file("${path.module}/secrets.yaml.encrypted")
  }
}
