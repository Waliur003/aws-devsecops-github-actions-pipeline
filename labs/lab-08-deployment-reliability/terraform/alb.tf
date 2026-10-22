resource "aws_lb" "app" {
  #checkov:skip=CKV_AWS_91:Access logging omitted for temporary learning environment.
  #checkov:skip=CKV_AWS_150:Deletion protection omitted so lab can be destroyed.
  #checkov:skip=CKV2_AWS_20:HTTPS redirect requires TLS certificate/domain.
  #checkov:skip=CKV2_AWS_28:WAF omitted for temporary low-cost lab.
  name                       = "devsecops-app-alb"
  internal                   = false
  load_balancer_type         = "application"
  drop_invalid_header_fields = true
  security_groups            = [aws_security_group.alb.id]
  subnets                    = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

resource "aws_lb_target_group" "app" {
  #checkov:skip=CKV_AWS_378:Internal ALB-to-container traffic uses HTTP for learning lab.
  name        = "devsecops-app-tg"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

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
}

resource "aws_lb_listener" "http" {
  #checkov:skip=CKV_AWS_2:HTTP retained because no ACM certificate/domain is configured.
  #checkov:skip=CKV_AWS_103:TLS policy not applicable to HTTP-only lab.
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
