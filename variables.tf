
variable "prisma_key" {
   type = string
}

variable "prisma_secret" {
   type = string
}

variable "prisma_url" {
   type = string
}

variable "count-of_each-aws" {
   type = number
   default=4
}

variable "count-of_each-gcp" {
   type = number
   default=4
}



