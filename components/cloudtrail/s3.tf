resource "aws_s3_bucket" "this" {
  bucket        = "kis9a-${var.service}"
  force_destroy = true
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "awscloudtrailaclcheck",
        Effect = "allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action   = "s3:getbucketacl",
        Resource = "arn:aws:s3:::kis9a-${var.service}"
      },
      {
        Sid    = "awscloudtrailwrite",
        Effect = "allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action   = "s3:putobject",
        Resource = "arn:aws:s3:::kis9a-${var.service}/awslogs/${data.aws_caller_identity.this.account_id}/*",
        Condition = {
          Stringequals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

data "aws_caller_identity" "this" {}
