resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.task1_s3bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.task1_s3bucket.id
 
     custom_origin_config {
            http_port = 80
            https_port = 443
            origin_protocol_policy = "match-viewer"
            origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
        }
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.task1_s3bucket.id
forwarded_values {
      query_string = false
cookies {
        forward = "none"
      }
    }
   viewer_protocol_policy = "allow-all"
  }
 price_class = "PriceClass_200"
restrictions {
        geo_restriction {
        restriction_type = "none"
        }
    }
 viewer_certificate {
    cloudfront_default_certificate = true
  }
 depends_on = [aws_s3_bucket.task1_s3bucket]
}
