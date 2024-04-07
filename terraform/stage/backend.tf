terraform {
  backend "s3" {
    bucket = "nimasoufiani-blog-stage-backend"
    key    = "backend"
    region = "eu-west-2"
  }
}
