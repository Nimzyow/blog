terraform {
  backend "s3" {
    bucket = "nimasoufiani-blog-stage-backend"
    key    = "backend"
    region = "us-east-1"
  }
}
