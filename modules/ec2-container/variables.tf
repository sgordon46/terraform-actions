variable "vpc" {
   type = string
   default = "vpc-401edd3d"
   description = "VPC"  
}

variable "dns_zone" {
   type = string
   default = "Z03463741RM0EQ9QMBK5W"
   description = "DNS Zone ID"  
}

variable "instance-type" {
   type = string
   default = "t3.medium"
   description = "Instance Type"  
}

variable "ami" {
   type = string
   default = "ami-053b0d53c279acc90"
   description = "AWS AMI id"  
}

variable "tl_short_name" {
   type = string
   description = "Short Name for Resources"
}

variable "tl_username" {
   type = string
}

variable "tl_password" {
   type = string
}

variable "tl_console" {
   type = string
}




