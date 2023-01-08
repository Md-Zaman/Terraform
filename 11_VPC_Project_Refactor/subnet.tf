# --- Public Subnet ---

resource "aws_subnet" "PublicSubnetA" {
  vpc_id                  = aws_vpc.mainvpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "PublicSubnet_A"
  }
  depends_on = [
    aws_vpc.mainvpc
  ]
}

# --- Private Subnet ---

resource "aws_subnet" "PrivateSubnetB" {
  vpc_id             = aws_vpc.mainvpc.id
  cidr_block         = var.private_subnet_cidr
  availability_zone  = "us-east-1a"

  tags = {
    "Name" = "PrivateSubnet_B"
  }
  depends_on = [
    aws_vpc.mainvpc
  ]
}