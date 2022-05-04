output "managed_rule_arn" {
  value = aws_wafv2_web_acl.managed.arn
}

output "cloudfront_basic_authentication" {
  value = aws_wafv2_web_acl.cloudfront_basic_authentication.arn
}
