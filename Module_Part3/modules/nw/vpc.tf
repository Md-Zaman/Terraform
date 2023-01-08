resource "aws_vpc" "my_vpc" {
  cidr_block = "${var.cidr_block}"
  instance_tenancy = "${var.instance_tenancy}"
  tags = {
    Name = "ZamanCustomVPC"
  }
}

resource "aws_subnet" "my_subnet" {
    vpc_id = "${var.vpc_id}"
    cidr_block = "${var.cidr_subnet}"
    tags = {
      Name = "Subnet_Module_demo"
    }
    availability_zone = "${var.availability_zone}"
    depends_on = [aws_vpc.my_vpc]
}

output "vpc_id" {
  value = "${aws_vpc.my_vpc.id}"
}

output "aws_subnet" {
  value = "${aws_subnet.my_subnet.id}"
}