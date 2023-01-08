# ------ Security Group for Public EC2 Instances ------
resource "aws_security_group" "ec2_public_SG" {
  name        = "ec2_public_SG"
  description = "Internet Access for Public EC2"
  vpc_id      = "${aws_vpc.mainvpc.id}"
  
  ingress {
    description      = "SSH inbound traffic Public EC2s"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups  = ["${aws_security_group.ELB_SG.id}"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "ec2_public_SG"
  }
  depends_on = [
    aws_vpc.mainvpc,
    aws_security_group.ELB_SG
  ] 
}

# ------ Security Group for Private EC2 Instances ------
resource "aws_security_group" "ec2_private_SG" {
  name        = "ec2_private_SG"
  description = "Internet Access for Public EC2"
  vpc_id      = "${aws_vpc.mainvpc.id}"
  
  ingress {
    description      = "SSH inbound traffic Public EC2s"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups  = ["${aws_security_group.ec2_public_SG.id}"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "ec2_private_SG"
  }
  depends_on = [
    aws_vpc.mainvpc,
    aws_security_group.ec2_public_SG
  ] 
}

# ------ Security Group for Load Balancer ------
resource "aws_security_group" "ELB_SG" {
  name        = "Allow all http traffice"
  description = "Allow all http traffice"
  vpc_id      = aws_vpc.mainvpc.id

  ingress {
    description      = "Allow all http traffice"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ELB_SG"
  }
}