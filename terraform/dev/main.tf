terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41"
    }
  }
}

locals {
  tag_name = "terraform"
  name     = "nimasoufiani"
  env      = "dev"
}


provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "nimasoufiani-blog" {
  bucket = "${local.name}-blog-${local.env}"
  tags = {
    "Name" = local.tag_name
    "Env"  = local.env
  }
}

resource "aws_cloudfront_origin_access_control" "nimasoufiani-blog-origin-access-control" {
  name                              = aws_s3_bucket.nimasoufiani-blog.bucket_domain_name
  signing_protocol                  = "sigv4"
  signing_behavior                  = "always"
  origin_access_control_origin_type = "s3"
}

resource "aws_cloudfront_distribution" "nimasoufiani-blog-cloudfront-distribution" {
  origin {
    origin_access_control_id = aws_cloudfront_origin_access_control.nimasoufiani-blog-origin-access-control.id
    origin_id                = aws_s3_bucket.nimasoufiani-blog.id
    domain_name              = aws_s3_bucket.nimasoufiani-blog.bucket_domain_name
  }
  enabled             = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["GB", "US"]
    }
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id       = aws_s3_bucket.nimasoufiani-blog.id
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  tags = {
    "Name" = local.tag_name
    "Env"  = local.env
  }
}

resource "aws_s3_bucket_ownership_controls" "nimasoufiani-blog-ownership-controls" {
  bucket = aws_s3_bucket.nimasoufiani-blog.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "nimasoufiani-blog-bucket-policy" {
  bucket = aws_s3_bucket.nimasoufiani-blog.id
  policy = <<EOT
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipalReadOnly",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.nimasoufiani-blog.arn}/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "${aws_cloudfront_distribution.nimasoufiani-blog-cloudfront-distribution.arn}"
                }
            }
        }
    ]
}
EOT
}
