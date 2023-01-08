variable "cidr_block" {
  default = "192.168.0.0/16"
  #192.168.0.0 - 192.168.255.255
}

variable "instance_tenancy" {
  default = "dedicated"
}

variable "vpc_id" {
  default = {}
}

variable "cidr_subnet" {
  default = "192.168.1.0/24"
  #192.168.1.0 - 192.168.1.255
}

variable "availability_zone" {
  default = "us-east-1a"
}

