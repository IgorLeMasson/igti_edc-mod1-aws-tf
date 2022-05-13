terraform {
  backend "s3" {
    bucket = "terraform-state-ilmp-igti-edc"
    key    = "terraform/igti-modulo-1/terraform.tfstate"
    region = "us-east-1"
  }
}