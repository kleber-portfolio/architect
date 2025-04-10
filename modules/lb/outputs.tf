output "lb_arn" {
  description = "ARN do Load Balancer"
  value       = aws_lb.this.arn
}

output "lb_dns_name" {
  description = "DNS público do Load Balancer"
  value       = aws_lb.this.dns_name
}

output "lb_security_group_id" {
  description = "ID do Security Group associado ao Load Balancer"
  value       = aws_security_group.lb_sg.id
}

output "target_group_arn" {
  description = "ARN do Target Group"
  value       = aws_lb_target_group.this.arn
}

output "listener_arn" {
  description = "ARN do Listener HTTP"
  value       = aws_lb_listener.lb_listener.arn
}
