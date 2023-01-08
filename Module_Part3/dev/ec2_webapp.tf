module "my_vpc" {
  source = "../modules/nw"
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"
  vpc_id = "${module.my_vpc.vpc_id}"
  cidr_subnet = "192.168.1.0/24"
}

module "my_ec2" {
  source = "../modules/ec2"
  instance_type = "t2.nano"
  ec2_name = "my_dev_EC2"
  sub_id = "${module.my_vpc.subnet_id}"
}