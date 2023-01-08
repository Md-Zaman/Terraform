resource "aws_instance" "FE_ec2" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    "Name" = "FE_ec2"
  }
  vpc_security_group_ids = [
    aws_security_group.allow_http.id
  ]
    subnet_id = var.subnet_id
}

# ---Seperator for another ec2 BE---

resource "aws_instance" "BE_ec2" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    "Name" = "BE_ec2"
  }  
    subnet_id = var.subnet_id
    vpc_security_group_ids = [
        aws_security_group.allow_http.id
  ]
}
