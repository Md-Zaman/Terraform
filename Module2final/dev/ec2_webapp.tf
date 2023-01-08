module "my_ec2" {
  source = "../modules/ec2"
  instance_type = "t2.nano"
  ec2_name = "my_dev_EC2"
}