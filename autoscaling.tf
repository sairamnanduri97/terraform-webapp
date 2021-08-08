resource "aws_launch_configuration" "vprofile-launch-config" {
  name_prefix          = "vprofile-tomcat-launch-config"
  image_id             = aws_ami_from_instance.tomcat-ami.id
  instance_type        = "t2.micro"
  iam_instance_profile = "s3_profile"
  security_groups      = [aws_security_group.app-sg.id]
  key_name             = "sai-kp"
}

resource "aws_autoscaling_policy" "asg-policy" {
  name                   = "vprofile-asg policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.vprofile-asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

resource "aws_ami_from_instance" "tomcat-ami" {
  name               = "vprofile-tomcat-ami"
  source_instance_id = aws_instance.tomcat-ec2.id
}

resource "aws_autoscaling_group" "vprofile-asg" {
  name                 = "vprofile-asg"
  launch_configuration = aws_launch_configuration.vprofile-launch-config.name
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  vpc_zone_identifier  = [aws_subnet.tfpublicsubnet1.id, aws_subnet.tfpublicsubnet2.id]
  target_group_arns    = [aws_lb_target_group.vprofile-target-group.arn]
  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "Tomcat-ASG"
    propagate_at_launch = true
  }
}