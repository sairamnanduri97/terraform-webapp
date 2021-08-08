resource "aws_route_table" "tfpublicrt" {
  vpc_id = aws_vpc.vprofile-vpc.id

  route {
    cidr_block = var.alltraffic
    gateway_id = aws_internet_gateway.tfigw.id
  }

  tags = {
    Name = "vprofile-pub-rt"
  }
}
resource "aws_route_table_association" "publicsubnetrtasso" {
  subnet_id      = aws_subnet.tfpublicsubnet1.id
  route_table_id = aws_route_table.tfpublicrt.id

}

resource "aws_route_table_association" "publicsubnetrtasso2" {
  subnet_id      = aws_subnet.tfpublicsubnet2.id
  route_table_id = aws_route_table.tfpublicrt.id

}