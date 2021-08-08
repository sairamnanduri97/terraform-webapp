resource "aws_lb_target_group" "vprofile-target-group" {
  name     = "vprofile-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vprofile-vpc.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 5
    interval            = 30
    path                = "/login"
    port                = "8080"
  }

}

resource "aws_lb_target_group_attachment" "tgattch" {
  target_group_arn = aws_lb_target_group.vprofile-target-group.arn
  target_id        = aws_instance.tomcat-ec2.id
  port             = 8080
}


resource "aws_lb" "vprofile-alb" {
  name                       = "vprofile-lb-tf"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false
  security_groups            = [aws_security_group.elb-sg.id]
  subnets                    = [aws_subnet.tfpublicsubnet1.id, aws_subnet.tfpublicsubnet2.id]

  tags = {
    Project = "vprofile"
  }
}

resource "aws_lb_listener" "vprofile-alb-HTTPS-listner" {
  load_balancer_arn = aws_lb.vprofile-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:144843234095:certificate/bf87ed8c-d6d0-4c6c-af73-d0c67a33c9a1"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vprofile-target-group.arn
  }
}
resource "aws_lb_listener" "vprofile-alb-HTTP-listner" {
  load_balancer_arn = aws_lb.vprofile-alb.arn
  port              = "80"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:144843234095:certificate/bf87ed8c-d6d0-4c6c-af73-d0c67a33c9a1"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vprofile-target-group.arn
  }
}