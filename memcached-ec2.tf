resource "aws_instance" "memcached-ec2" {
  ami                         = "ami-00e87074e52e6c9f9"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.backend-sg.id]
  subnet_id                   = aws_subnet.tfpublicsubnet1.id
  associate_public_ip_address = true #tfsec:ignore:AWS012
  private_ip                  = "22.0.1.126"
  user_data                   = file("memcache.sh")
  key_name                    = "sai-kp"
  tags = {
    Name    = "Memcached"
    Project = "vprofile"
  }
}