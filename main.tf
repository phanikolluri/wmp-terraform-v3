resource "aws_instance" "instance" {
  for_each =  var.COMPONENTS
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0ce01673ed9893e29"]

  tags = {
    Name = each.key
  }
}

resource "aws_route53_record" "route-setup" {
  for_each = var.COMPONENTS
  zone_id = "Z02549774QMYGMZM7W06"
  name    = "${each.key}-dev"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.key].private_ip]
}


variable "COMPONENTS" {
    default= {
        frontend = ""
        postgresql = ""
        portfolio-service = ""
        auth-service = ""   
        analytics-service = ""
    }
}