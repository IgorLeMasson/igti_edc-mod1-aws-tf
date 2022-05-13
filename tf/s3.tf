resource "aws_s3_bucket" "data_lake" {
  bucket = "datalake-ilmp-igti-edc"
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


# Uploading files to S3
resource "aws_s3_bucket_object" "datasets" {
  for_each = fileset("../data/", "*.txt")
  bucket = aws_s3_bucket.data_lake.id
  key    = "${each.value}"
  source = "./raw-data/RAIS/${each.value}"
  etag   = filemd5("../data/${each.value}")
}


provider "aws" {
  region = "us-east-1"
}