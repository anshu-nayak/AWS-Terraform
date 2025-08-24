terraform {
  backend "s3" {
    bucket = "aws-project-terraform-state-file"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}