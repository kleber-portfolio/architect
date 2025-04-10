variable "app_name" {
  type        = string
  description = "Nome da aplicação"
}

variable "environment" {
  type        = string
  description = "Ambiente da aplicação"
}

variable "region" {
  type        = string
  description = "Região da AWS"
}

variable "cluster_id" {
  type        = string
  description = "ID do ECS Cluster"
}

variable "image_uri" {
  type        = string
  description = "URI da imagem Docker"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Lista de subnets privadas"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "lb_listener_arn" {
  type        = string
  description = "ARN do Listener do Load Balancer"
}

variable "lb_security_group_id" {
  type        = string
  description = "Security Group ID do Load Balancer"
}

variable "lb_target_group_arn" {
  description = "ARN do Target Group"
  type        = string
}

variable "container_port" {
  description = "Porta do container"
  type        = number
}

variable "cpu" {
  description = "Unidades de CPU para a task"
  type        = string
}

variable "memory" {
  description = "Memória em MB para a task"
  type        = string
}

variable "desired_count" {
  description = "Número desejado de tasks"
  type        = number
}

variable "min_capacity" {
  description = "Capacidade mínima do autoscaling"
  type        = number
}

variable "max_capacity" {
  description = "Capacidade máxima do autoscaling"
  type        = number
}

variable "dynamodb_table_arn" {
  type        = string
  description = "ARN da tabela DynamoDB"
}

variable "listener_rule_priority" {
  description = "Prioridade da regra do listener do Load Balancer"
  type        = number
}