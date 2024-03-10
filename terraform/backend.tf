terraform {
  backend "s3" {
    bucket = "blog-backend-nimasoufiani"
    key    = "backend"
    region = "eu-west-2"
  }
}
