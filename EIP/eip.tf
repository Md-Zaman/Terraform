resource "aws_eip" "ec2fromTfforEIP" {
  instance = "${aws_instance.ec2InstanceforTfEIP.id}"
  vpc      = true
}
output "my_eip_address" {
  value = "${aws_eip.ec2fromTfforEIP.public_ip}"
}