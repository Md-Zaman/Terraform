resource "aws_instance" "ec2Createdbyzaman" {
    ami = "ami-0b5eea76982371e91"
    instance_type = "t2.micro"
    tags = {
      "Name" = "ec2Createdbyzaman"

    }
    key_name = "NewKP"
    user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd.service
    systemctl enable httpd.service
    echo "Hi Friend , I am $(hostname -f) hosted by Terraform for EIP Demo" > /var/www/html/index.html
    EOF
}

resource "aws_instance" "ec2Createdbymd" {
 ami = ""
 instance_type = ""
}