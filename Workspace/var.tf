variable "ami" {
  default = "ami-0b5eea76982371e91"
}
variable "instance_type" {
  default = "t2.micro"
  prod    = "t2.large"
  dev     = "t2.nano"
}
variable "ec2_name" {
  default = "",
  prod    = "prod_ec2_workspace_demo",
  dev     = "dev_ec2_workspace_demo"
}
variable "availability_zone" {
  default = "us-east-1a"
}

