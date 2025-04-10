resource "aws_lb" "this" {
  name               = "${var.lb_name}-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnet_ids

  tags = {
    Name        = "${var.lb_name}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.lb_name}-tg-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    protocol            = "HTTP"
    path                = "/actuator/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    Name        = "${var.lb_name}-tg-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "${var.lb_name}-sg-lb-${var.environment}"
  description = "Allow HTTP inbound and all outbound"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.lb_name}-sg-lb-${var.environment}"
    Environment = var.environment
  }
}