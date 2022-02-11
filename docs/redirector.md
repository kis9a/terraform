### redirector module

redirector module [modules/redirector](../modules/redirector)

origin request redirect to s3 bucket, s3 redirect all request to target url.

```
resource "aws_cloudfront_distribution" "main" {
# ...
  origin {
# ...
    origin_id   = "origin-${var.fqdn}"
    domain_name = aws_s3_bucket.main.website_endpoint
  }
}

resource "aws_s3_bucket" "main" {
# ...
  website {
    redirect_all_requests_to = var.redirect_target
  }
}
```

### ACM

ACM ssl certificate managed by [domains](../domains)

reference ssl certificate arn by data.terraform_remote_state.outpts.

see [domains/outputs.tf](../domains/outputs.tf)

```
data "terraform_remote_state" "domains" {
  backend = "s3"

  config = {
    key     = "terraform-me.tfstate"
    bucket  = "kis9a-terraform-states"
    region = "ap-northeast-1"
    profile = "kis9a"
  }
}
```
