terraform {
  backend "s3" {
    bucket = "nimasoufiani-blog-prod-backend"
    key    = "backend"
    region = "eu-west-2"
  }
}
