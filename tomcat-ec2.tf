resource "aws_instance" "tomcat-ec2" {
  ami                         = "ami-013f17f36f8b1fefb"
  instance_type               = "t2.micro"
  iam_instance_profile        = "s3_profile"
  vpc_security_group_ids      = [aws_security_group.app-sg.id]
  subnet_id                   = aws_subnet.tfpublicsubnet1.id
  associate_public_ip_address = true #tfsec:ignore:AWS012
  private_ip                  = "22.0.1.42"
  user_data                   = file("tomcat_ubuntu.sh")
  key_name                    = "sai-kp"
  tags = {
    Name = "Tomcat"
  }
}


resource "aws_iam_role" "s3-role" {
  name = "s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "test_policy" {
  name = "s3_role_policy"
  role = aws_iam_role.s3-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*",
        Effect   = "Allow",
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "s3_profile" {
  name = "s3_profile"
  role = aws_iam_role.s3-role.name
}