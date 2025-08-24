terraform {
  backend "s3" {
    bucket = "aws-project-terraform-state"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}