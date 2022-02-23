resource "aws_cloudtrail" "this" {
  name                          = var.service
  s3_bucket_name                = aws_s3_bucket.this.id
  include_global_service_events = false
}
