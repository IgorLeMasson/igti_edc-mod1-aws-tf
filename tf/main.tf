terraform {
  backend "s3" {
    bucket = "igti-iac-file-state"
    key    = "terraform/igti-modulo-1/terraform.tfstate"
    region = "us-east-2"
  }
}