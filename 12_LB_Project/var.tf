variable "region" {
  
}

variable "vpc_cidr" {

}

variable "ami" {
  default = "ami-0b5eea76982371e91"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "public_subnet_cidr" {
  type = list
}

variable "private_subnet_cidr" {
  type = list
}

variable "availability_zone" {
  type = list
}

variable "public_subnet_name" {
  type = list
}

variable "private_subnet_name" {
  type = list
}
