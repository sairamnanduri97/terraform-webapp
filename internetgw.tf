resource "aws_internet_gateway" "tfigw" {
  vpc_id = aws_vpc.vprofile-vpc.id

  tags = {
    Name = "vprofile-igw"
  }
}