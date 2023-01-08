resource "aws_instance" "FE_ec2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  tags = {
    "Name" = "FE_ec2"
  }
  vpc_security_group_ids = [
    aws_security_group.allow_http.id
  ]
    subnet_id = "subnet-05a309a4b74d7f8fa"
}

# ---Seperator for another ec2 BE---

resource "aws_instance" "BE_ec2" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  tags = {
    "Name" = "BE_ec2"
  }  
    subnet_id = "subnet-05a309a4b74d7f8fa"
    vpc_security_group_ids = [
        aws_security_group.allow_http.id
  ]
}
