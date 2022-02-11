## about

basic authentication for awsc loudfront distribution
infrastructure: request -> lambda@Edge -> cloudfront distribution

## encrypt credentials

```
## example decrypt
kms_decrypt secrets.yaml.encrypted kis9a us-east-1 > secrets.yaml

# edit secrets.yaml
user: xxxxxxxx
password: xxxxxxxxxxxxxxxx

## example encrypt
kms_encrypt basic-auth-stag secrets.yaml kis9a us-east-1 > secrets.yaml.encrypted
```

[KMS_ENCRYPT_DECRYPT](../DOCS/KMS_ENCRYPT_DECRYPT.MD)

## association

```
module "cloudfront" {
  lambda_function_associations = [{
    event_type   = "viewer-request"
    include_body = false
    lambda_arn   = data.terraform_remote_state.basic_auth.outputs.lambda_qualified_arn
  }]
}

# in cloudfront module
resource "aws_cloudfront_distribution" "frontend" {
# ...
  default_cache_behavior {
# ...
    dynamic "lambda_function_association" {
      for_each = var.lambda_function_associations

      content {
        event_type   = lambda_function_association.value.event_type
        include_body = lambda_function_association.value.include_body
        lambda_arn   = lambda_function_association.value.lambda_arn
      }
    }
  }


data "terraform_remote_state" "basic_auth" {
  backend = "s3"

  config = {
    key     = "terraform-basic-auth-stag.tfstate"
    bucket                 = "kis9a-terraform-states"
    profile = "kis9a"
    region  = "ap-northeast-1"
  }
}
```
