# Create a VPC
resource "aws_vpc" "vprofile-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "DevOps"
  }
}