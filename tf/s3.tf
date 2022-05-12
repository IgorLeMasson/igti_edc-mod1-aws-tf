resource "aws_s3_bucket" "data_lake" {
  bucket = "igti-data-lake"
}

resource "aws_s3_bucket_acl" "s3_acl_data_lake" {
  bucket = aws_s3_bucket.data_lake.id
  acl = "private"
}

resource "aws_s3_bucket" "scripts" {
  bucket = "igti-scripts"
}

resource "aws_s3_bucket_acl" "s3_acl_scripts" {
  bucket = aws_s3_bucket.scripts.id
  acl = "private"
}


resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.scripts.id
  key    = "rais_etl.py"
  acl = "private"
  source = "../rais_etl.py"
  etag = filemd5("../rais_etl.py")
}

provider "aws" {
  region = "us-east-2"
}