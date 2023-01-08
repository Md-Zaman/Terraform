resource "aws_vpc" "mainvpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    "Name" = "VPC_TF"
  }

}

# ------ Security Group ------
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "allow SSH inbound Traffic/ allow all outbound Traffic"
  vpc_id      = "${aws_vpc.mainvpc.id}"
  
  ingress {
    description      = "SSH inbound traffic VPC"
    from_port        = 22
    to_port          = 22
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
    "Name" = "Security_Group_TF"
  }
  depends_on = [
    aws_vpc.mainvpc
  ] 
}

# ------ Internet Gateway ------
  resource "aws_internet_gateway" "IGW_TF" {
    vpc_id = aws_vpc.mainvpc.id
    tags = {
      "Name" = "IGW_TF"
    }
    depends_on = [
      aws_vpc.mainvpc
    ]
  }

# ------ Elastic IP ------
  resource "aws_eip" "eip_tf" {
    vpc = true
    tags = {
      "Name" = "EIP_TF"
    }
  }

# ------ NAT Gateway ------
  resource "aws_nat_gateway" "NATGW" {
    allocation_id = aws_eip.eip_tf.id
    subnet_id = aws_subnet.PublicSubnetA.id
    tags = {
      "Name" = "NATGW"
    }
    depends_on = [
      aws_eip.eip_tf,
      aws_subnet.PublicSubnetA
    ]
  }