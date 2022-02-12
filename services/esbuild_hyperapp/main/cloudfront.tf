resource "aws_cloudfront_distribution" "website_cdn" {
  aliases = [var.domain]
  enabled = true

  origin {
    origin_id   = "origin-bucket-${aws_s3_bucket.deploy_bucket.id}"
    domain_name = aws_s3_bucket.deploy_bucket.website_endpoint

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "DELETE", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    min_ttl                = 86400
    default_ttl            = 172800
    max_ttl                = 2592000
    target_origin_id       = "origin-bucket-${aws_s3_bucket.deploy_bucket.id}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_page_path    = "/index.html"
    response_code         = 200
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 403
    response_page_path    = "/index.html"
    response_code         = 200
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.terraform_remote_state.domains.outputs.sub_kis9a_virginia_ssl_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
