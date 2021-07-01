
resource "aws_s3_bucket" "b1"{
	bucket="udaykanchiaws"
	acl="public-read"

}



resource "aws_s3_bucket_object" "object"{

bucket = aws_s3_bucket.b1.id
key= "index.html"
source = "myfiles/index.html"
etag= filemd5("myfiles/index.html")
content_type = "text/html"
}



resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "udaykanchiaws.s3.amazonaws.com"
    origin_id   = "myS3Origin"

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/E8ERFI73R9KFO"
    }
  }

  enabled             = true
  comment             = "Some comment"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myS3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE","IN"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
