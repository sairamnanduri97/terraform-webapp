resource "aws_subnet" "tfpublicsubnet1" {
  vpc_id            = aws_vpc.vprofile-vpc.id
  cidr_block        = var.sub1_cidr_range
  availability_zone = var.az_01[0]

  tags = {
    Name = "vprofile-pub-sub-1"
  }
}

resource "aws_subnet" "tfpublicsubnet2" {
  vpc_id            = aws_vpc.vprofile-vpc.id
  cidr_block        = var.sub2_cidr_range
  availability_zone = var.az_01[1]

  tags = {
    Name = "vprofile-pub-sub-2"
  }
}
