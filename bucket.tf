provider "aws" {
  access_key = "key"
  secret_key = "key"

  region  = "ap-south-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "udaykanchi-aws"
  acl    = "private"
}
