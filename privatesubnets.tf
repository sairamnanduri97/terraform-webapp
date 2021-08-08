resource "aws_subnet" "tfprivatesubnet1" {
  vpc_id            = aws_vpc.vprofile-vpc.id
  cidr_block        = var.prisub1_cidr_range
  availability_zone = var.az_01[0]

  tags = {
    Name = "vprofile-private-sub-1"
  }
}

resource "aws_subnet" "tfprivatesubnet2" {
  vpc_id            = aws_vpc.vprofile-vpc.id
  cidr_block        = var.prisub2_cidr_range
  availability_zone = var.az_01[1]

  tags = {
    Name = "vprofile-private-sub-2"
  }
}

