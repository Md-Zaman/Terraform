resource "aws_route_table" "PublicRouteTable" {
  vpc_id       = aws_vpc.mainvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW_TF.id
  }

  tags = {
    "Name" = "PublicRouteTable"
  }
  depends_on = [
    aws_vpc.mainvpc,
    aws_internet_gateway.IGW_TF

  ]
}

# ---- Public Route Table Association ----
resource "aws_route_table_association" "PublicRouteTableAssociation" {
    subnet_id      = aws_subnet.PublicSubnetA.id
    route_table_id = aws_route_table.PublicRouteTable.id
    depends_on = [
      aws_subnet.PublicSubnetA, 
      aws_route_table.PublicRouteTable
    ]
}

# ---- Private Route Table ----
resource "aws_route_table" "PrivateRouteTable" {
  vpc_id       = aws_vpc.mainvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NATGW.id
  }
  tags = {
    "Name" = "PrivateRouteTable"
  }
  depends_on = [
    aws_vpc.mainvpc,
    aws_nat_gateway.NATGW

  ]
}
resource "aws_route_table_association" "PrivateRouteTableAssociation" {
    subnet_id = aws_subnet.PrivateSubnetB.id
    route_table_id = aws_route_table.PrivateRouteTable.id
    depends_on = [
      aws_subnet.PublicSubnetA, 
      aws_route_table.PrivateRouteTable
    ]
}