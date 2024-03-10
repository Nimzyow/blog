terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.36"
    }
  }
}


provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "nimasoufiani-blog" {
  bucket = "nimasoufiani-blog"
}

resource "aws_cloudfront_distribution" "nimasoufiani-blog-cloudfront-distribution" {

}

data "aws_iam_policy_document" "nimasoufiani-blog-policy-document" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    effect    = "Allow"
    sid       = "AllowCloudFrontServicePrincipal"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.nimasoufiani-blog.arn}/"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.nimasoufiani-blog-cloudfront-distribution.arn]
    }
  }
}

# resource "aws_s3_bucket_ownership_controls" "nimasoufiani-blog-ownership-controls" {
#   bucket = aws_s3_bucket.nimasoufiani-blog.id
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }

# }
