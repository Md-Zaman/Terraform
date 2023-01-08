resource "aws_instance" "EC2InstanceforModule1" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  security_groups = ["default"]
  tags = {
    Name = "${var.ec2_name}"
  }
  availability_zone = "${var.availability_zone}"
}