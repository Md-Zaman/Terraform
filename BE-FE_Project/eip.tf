resource "aws_eip" "FE_EIP" {
  instance = aws_instance.FE_ec2.id
}