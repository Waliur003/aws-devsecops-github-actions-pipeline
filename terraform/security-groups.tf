resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  description = "Security group for the Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}


resource "aws_security_group" "ecs" {
  name        = "${var.project_name}-ecs-sg"
  description = "Security group for ECS Fargate tasks"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-ecs-sg"
  }
}


resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  #checkov:skip=CKV_AWS_260:Public HTTP ingress is intentionally used for this temporary lab.

  security_group_id = aws_security_group.alb.id

  description = "Allow HTTP from the internet"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "alb_to_ecs" {
  security_group_id = aws_security_group.alb.id

  description = "Allow ALB traffic to ECS application port"

  referenced_security_group_id = aws_security_group.ecs.id

  from_port   = 5000
  to_port     = 5000
  ip_protocol = "tcp"
}


resource "aws_vpc_security_group_ingress_rule" "ecs_from_alb" {
  security_group_id = aws_security_group.ecs.id

  description = "Allow application traffic from ALB"

  referenced_security_group_id = aws_security_group.alb.id

  from_port   = 5000
  to_port     = 5000
  ip_protocol = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "ecs_https" {
  security_group_id = aws_security_group.ecs.id

  description = "Allow HTTPS outbound for ECR, CloudWatch and AWS APIs"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "ecs_dns_udp" {
  security_group_id = aws_security_group.ecs.id

  description = "Allow DNS UDP inside VPC"

  cidr_ipv4   = "10.0.0.0/16"
  from_port   = 53
  to_port     = 53
  ip_protocol = "udp"
}


resource "aws_vpc_security_group_egress_rule" "ecs_dns_tcp" {
  security_group_id = aws_security_group.ecs.id

  description = "Allow DNS TCP inside VPC"

  cidr_ipv4   = "10.0.0.0/16"
  from_port   = 53
  to_port     = 53
  ip_protocol = "tcp"
}