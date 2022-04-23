module "lambda" {
  source          = "../modules/lambda"
  service         = var.service
  env             = var.env
  lambda_role_arn = module.iam.lambda_role_arn
  path_function   = abspath("../../../functions/cloudfront_basic_authentication")
  basic_auth_credentials = {
    user     = local.basic_auth_secrets.user
    password = local.basic_auth_secrets.password
  }
}

locals {
  basic_auth_secrets = yamldecode(data.aws_kms_secrets.basic_auth_secrets.plaintext["${var.service}_secrets"])
}
