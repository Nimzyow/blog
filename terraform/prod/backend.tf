terraform {
  backend "s3" {
    bucket = "nimasoufiani-blog-prod-backend"
    key    = "backend"
    region = "us-east-1"
  }
}
