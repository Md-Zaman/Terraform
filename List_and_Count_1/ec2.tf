resource "aws_instance" "my_ec2" {
  count = "${length(var.availability_zone)}"
  ami = var.ami
  instance_type = var.instance_type
  availability_zone = "${element(var.availability_zone, count.index)}"
  tags = {
    "Name" = "my_ec2_${element(var.availability_zone, count.index)}"
  }
}

output "Myec2" {
  value = aws_instance.my_ec2
  }