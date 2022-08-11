

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
    count=6
    source = "./modules/ec2-container"
    tl_short_name ="vm.${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url
}

module "vm2"{
    count=6
    source = "./modules/ec2-host"
    tl_short_name ="vm2.${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url
}