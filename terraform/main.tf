terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.36"
    }
  }
}

locals {
  tag_name = "terraform"
}


provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "nimasoufiani-blog" {
  bucket = "nimasoufiani-blog"
  tags = {
    "Name" = local.tag_name
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
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["GB"]
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
  }
}

resource "aws_iam_policy" "policy" {
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
        ]
        Effect   = "Allow"
        Resource = ["${aws_s3_bucket.nimasoufiani-blog.arn}/*"]

      },
    ]
  })
}

data "aws_iam_policy_document" "nimasoufiani-blog-policy-document" {
  statement {
    sid       = "AllowCloudFrontServicePrincipal"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.nimasoufiani-blog.arn}/*"]
    effect    = "Allow"
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.nimasoufiani-blog-cloudfront-distribution.arn]
    }
  }

}

resource "aws_iam_policy" "nimasoufiani-blog-iam-policy" {
  name   = "nimasoufiani-blog-iam-policy"
  policy = data.aws_iam_policy_document.nimasoufiani-blog-policy-document.json
  tags = {
    "Name" = local.tag_name
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
  policy = data.aws_iam_policy_document.nimasoufiani-blog-policy-document.json
}
