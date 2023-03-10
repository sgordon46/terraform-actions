#Add a comment to keep this active

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
    count=var.count-of_each-aws
    source = "./modules/ec2-container"
    tl_short_name ="vm.${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url
}

module "vm2"{
    count=var.count-of_each-aws
    source = "./modules/ec2-host"
    tl_short_name ="vm2.${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url
}

provider "google" {
  region = "us-central1"
  zone    = "us-central1-a"
}




module "vm-project1"{
    count=var.count-of_each-gcp
    source = "./modules/gcp-instance"
    project = "project1-366201"
    name = "vm-${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url

}

module "vm-project2"{
    count=var.count-of_each-gcp
    source = "./modules/gcp-instance"
    project = "project2-366201"
    name = "vm-${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url

}

module "vm-project3"{
    count=var.count-of_each-gcp
    source = "./modules/gcp-instance"
    project = "project-3-370416"
    name = "vm-${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url
}