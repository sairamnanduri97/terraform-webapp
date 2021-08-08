resource "aws_route_table" "tfprivatert" {
  vpc_id = aws_vpc.vprofile-vpc.id


  tags = {
    Name = "vprofile-private-rt"
  }
}
resource "aws_route_table_association" "privatesubnetrtasso1" {
  subnet_id      = aws_subnet.tfprivatesubnet1.id
  route_table_id = aws_route_table.tfprivatert.id

}

resource "aws_route_table_association" "privatesubnetrtasso2" {
  subnet_id      = aws_subnet.tfprivatesubnet2.id
  route_table_id = aws_route_table.tfprivatert.id

}