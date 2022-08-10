

terraform {
    backend "s3" {
    bucket = "strategic-east-terraform"
    key = "terraform-actions.tfstate"
    region = "us-east-1"
  }    
}

provider "aws" {

}


resource "aws_route53_record" "default" {

  name    = "sample.prismacompute.site"
  zone_id = "Z03463741RM0EQ9QMBK5W"
  ttl     = "60"
  type    = "A"
  records = ["8.8.8.8"]
}
