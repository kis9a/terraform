resource "aws_s3_bucket" "main" {
  bucket        = var.fqdn
  acl           = "private"
  policy        = data.aws_iam_policy_document.bucket_policy.json
  force_destroy = var.force_destroy
  tags = merge(
    var.tags,
    {
      "Name" = var.fqdn
    }
  )

  website {
    redirect_all_requests_to = var.redirect_target
  }
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid       = "AllowCFOriginAccess"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.fqdn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
