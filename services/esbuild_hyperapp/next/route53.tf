resource "aws_route53_record" "this" {
  zone_id = data.terraform_remote_state.domains.outputs.kis9a_host_zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.website_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}
