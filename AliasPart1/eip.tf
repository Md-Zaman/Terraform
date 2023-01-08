resource "aws_eip" "EIP_us-east-1" {
  vpc = true
  tags = {
    "Name" = "EIP_in_Virginia"
  }
}

resource "aws_eip" "EIP_eu-central_1" {
  provider = aws.frankfurt
  vpc = true
  tags = {
    "Name" = "EIP_in_Frankfurt"
  }
}