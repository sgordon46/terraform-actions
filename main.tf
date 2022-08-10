

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
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url
}