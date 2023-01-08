resource "aws_instance" "PublicEC2" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id = aws_subnet.PublicSubnetA.id
  key_name = "NewKP"
  tags = {
    "Name" = "PublicEC2"
  }
  depends_on = [
    aws_vpc.mainvpc,
    aws_subnet.PublicSubnetA,
    aws_security_group.allow_ssh
  ]
}

# ---Partician to Private EC2---

resource "aws_instance" "PrivateEC2" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id = aws_subnet.PrivateSubnetB.id
  key_name = "NewKP"
  tags = {
    "Name" = "PrivateEC2"
  }
  depends_on = [
    aws_vpc.mainvpc,
    aws_subnet.PrivateSubnetB,
    aws_security_group.allow_ssh
  ]
}

