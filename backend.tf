terraform {
  backend "s3" {
    bucket  = "vprofile-terraform-1436"
    key     = "sai-kp"
    encrypt = true
    region  = "us-east-1"
  }
}