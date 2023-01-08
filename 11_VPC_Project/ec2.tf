resource "aws_instance" "PublicEC2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
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

# ---Partician to another EC2---

resource "aws_instance" "PrivateEC2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
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

