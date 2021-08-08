//Backend Security group
resource "aws_security_group" "backend-sg" {
  name        = "db-securitygroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vprofile-vpc.id

  ingress {
    description     = "Allow tomcat to connect to Rabbitmq"
    from_port       = 5672
    to_port         = 5672
    protocol        = "tcp"
    security_groups = [aws_security_group.app-sg.id]
  }
  ingress {
    description     = "Allow tomcat to connect to Memcached"
    from_port       = 11211
    to_port         = 11211
    protocol        = "tcp"
    security_groups = [aws_security_group.app-sg.id]
  }
  ingress {
    description     = "Allow 3306 from application server"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app-sg.id]
  }
  ingress {
    description = "SSH to instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }
  ingress {
    description = "Allow all traffic to flow internally"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
  }

  tags = {
    Name    = "db-sg"
    Project = "vprofile"
  }
}

//ELB Security group
resource "aws_security_group" "elb-sg" {
  name        = "elb-securitygroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vprofile-vpc.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }
  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }
  ingress {
    description = "SSH to instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
  }

  tags = {
    Name    = "elb-sg"
    Project = "vprofile"
  }
}

//Application Security Group
resource "aws_security_group" "app-sg" {
  name        = "app-securitygroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vprofile-vpc.id

  ingress {
    description     = "Allow traffic from ELB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.elb-sg.id]
  }
  ingress {
    description = "SSH to instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS008
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS009
  }

  tags = {
    Name    = "app-sg"
    Project = "vprofile"
  }
}