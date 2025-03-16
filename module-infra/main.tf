terraform {
  required_providers {
	aws = {
	  source  = "hashicorp/aws"
	  version = "5.54.1"
	}
  }
}
resource "aws_security_group" "tool" {
  name = "${var.name}-sg"
  description = "${var.name}-sg"
  vpc_id = aws_vpc.vpc.id
  tags = {
	Name = "${var.name}-sg"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_sh" {
  security_group_id = aws_security_group.tool.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "allow_port" {
  security_group_id = aws_security_group.tool.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = var.port
  to_port = var.port
  ip_protocol = "tcp"
}

resource "aws_instance" "tools" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws.security_group.tool.id]
  tags = {
	Name = var.name
  }
}

resource "aws_route53_record" "private" {
  zone_id = var.zone_id
  name    = "${var.name}-private"
  type    = "A"
  ttl     = 10
  records = [aws_instance.tools.private_ip]
}

resource "aws_route53_record" "public" {
  zone_id = var.zone_id
  name    = "${var.name}-public"
  type    = "A"
  ttl     = 10
  records = [aws_instance.tools.public_ip]
}



