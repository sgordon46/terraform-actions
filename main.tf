provider "aws" {


  backend "s3" {
    bucket = "terraform-state"
    key = "terraform-actions.tfstate"
    region = "us-east-1"
  }    
}