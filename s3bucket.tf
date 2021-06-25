resource "aws_s3_bucket" "b1"{
	bucket="s3-uday-kanchi"
	acl = "public-read"
	
website {
    index_document = "index.html"
    error_document = "error.html"
  }
tags={
Name = "my bucket"
Environment = "dev"
}

}


resource "aws_s3_bucket_object" "object"{
acl = "public-read"
for_each = fileset("myfiles/","*")
bucket = aws_s3_bucket.b1.id
key= each.value
source = "myfiles/${each.value}"
etag= filemd5("myfiles/${each.value}")

}




