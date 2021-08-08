resource "aws_route53_record" "vprofileapp" {
  zone_id = "Z0616114IUF4NXYNW4JQ"
  name    = "vprofileapp.mydevopspractice.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.vprofile-alb.dns_name]
}