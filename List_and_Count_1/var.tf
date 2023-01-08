variable "ami" {
  default = "ami-0b5eea76982371e91"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "availability_zone" {
    type = list
    default = [ 
             "us-east-1a",
             "us-east-1b",
             "us-east-1c"
             ]
}
variable "ec2_name" {
  default = ""
}