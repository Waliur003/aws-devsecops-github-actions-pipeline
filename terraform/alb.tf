resource "aws_lb" "app" {
  #checkov:skip=CKV_AWS_91:ALB access logging omitted in temporary learning environment to avoid additional S3 infrastructure.
  #checkov:skip=CKV_AWS_150:Deletion protection omitted so the temporary lab can be destroyed cleanly.
  #checkov:skip=CKV2_AWS_20:HTTPS redirect requires a TLS certificate and domain; this lab intentionally uses HTTP.
  #checkov:skip=CKV2_AWS_28:AWS WAF omitted from temporary lab to avoid additional recurring cost.

  name                       = "devsecops-app-alb"
  internal                   = false
  load_balancer_type         = "application"
  drop_invalid_header_fields = true

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = {
    Name        = "${var.project_name}-alb"
    Environment = "lab"
  }
}


resource "aws_lb_target_group" "app" {
  #checkov:skip=CKV_AWS_378:Internal ALB-to-container traffic uses HTTP for this learning lab.

  name        = "devsecops-app-tg"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = aws_vpc.main.id

  health_check {
    enabled             = true
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = "${var.project_name}-target-group"
  }
}


resource "aws_lb_listener" "http" {
  #checkov:skip=CKV_AWS_2:HTTP listener retained for lab because no ACM certificate/domain is configured.
  #checkov:skip=CKV_AWS_103:TLS policy is not applicable to the intentionally HTTP-only lab listener.

  load_balancer_arn = aws_lb.app.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.app.arn
  }
}