terraform {
  backend "s3" {
    bucket = "nimasoufiani-blog-dev-backend"
    key    = "backend"
    region = "us-east-1"
  }
}
