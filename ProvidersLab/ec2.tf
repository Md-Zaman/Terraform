resource "aws_instance" "ProvisionerEC2" {
  ami = "ami-0b898040803850657"
  instance_type = "t2.micro"
  key_name = "NewKP"
  tags = {
      Name = "ProvisionerEC2"
  }
  provisioner "local-exec" {
command = "echo ${self.private_ip}" > private_ip.txt
}
}