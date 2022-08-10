

terraform {
    backend "s3" {
    bucket = "strategic-east-terraform"
    key = "terraform-actions.tfstate"
    region = "us-east-1"
  }    
}

provider "aws" {

}

module "vm1"{
    source = "./modules/ec2"
    tl_short_name ="vm1"
}