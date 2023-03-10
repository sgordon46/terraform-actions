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


module "vm-project1-h"{
    count=var.count-of_each-gcp
    source = "./modules/gcp-host"
    project = "project1-366201"
    name = "vm-host-${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url

}

module "vm-project2-h"{
    count=var.count-of_each-gcp
    source = "./modules/gcp-host"
    project = "project2-366201"
    name = "vm-host-${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url
}

module "vm-project3-h"{
    count=var.count-of_each-gcp
    source = "./modules/gcp-host"
    project = "project-3-370416"
    name = "vm-host-${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url
}

module "vm-project1-c"{
    count=var.count-of_each-gcp
    source = "./modules/gcp-container"
    project = "project1-366201"
    name = "vm-container-${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url

}

module "vm-project2-c"{
    count=var.count-of_each-gcp
    source = "./modules/gcp-container"
    project = "project2-366201"
    name = "vm-container-${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url
}

module "vm-project3-c"{
    count=var.count-of_each-gcp
    source = "./modules/gcp-container"
    project = "project-3-370416"
    name = "vm-container-${count.index}"
    tl_username = var.prisma_key
    tl_password = var.prisma_secret
    tl_console = var.prisma_url
}