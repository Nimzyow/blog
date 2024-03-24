output "nimasoufiani-blog-arn" {
  value = aws_s3_bucket.nimasoufiani-blog.arn
}

output "nimasoufiani-blog-bucket-name" {
  value = aws_s3_bucket.nimasoufiani-blog.bucket
}

output "cloudfront_distribution_url" {
  value = aws_cloudfront_distribution.nimasoufiani-blog-cloudfront-distribution.domain_name
}
