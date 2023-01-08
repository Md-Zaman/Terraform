resource "aws_instance" "ec2CreatedbyZaman" {
  ami = "ami-0b898040803850657"
  instance_type = "t2.micro"
  tags = {
      Name = "ec2CreatedbyZaman"
  }
}

resource "aws_instance" "ec2CreatedbyMd_Manually" {
  ami = "i-09c3ca714bdcf0477"
  instance_type = "t2.micro"
  tags = {
    "Name" = "ec2CreatedbyMd_Manually"
  }  
}

