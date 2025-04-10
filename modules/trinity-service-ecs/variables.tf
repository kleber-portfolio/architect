variable "app_name" {
  description = "Nome da aplicação"
  type        = string
}

variable "environment" {
  description = "Ambiente de implantação"
  type        = string
}

variable "cluster_id" {
  description = "ID do cluster ECS"
  type        = string
}

variable "image_uri" {
  description = "URI da imagem Docker"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets para a task"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "lb_listener_arn" {
  description = "ARN do listener do Load Balancer"
  type        = string
}

variable "lb_target_group_arn" {
  description = "ARN do Target Group"
  type        = string
}

variable "lb_security_group_id" {
  description = "ID do Security Group do Load Balancer"
  type        = string
}

variable "region" {
  description = "Região da AWS"
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
  description = "ARN da tabela DynamoDB acessada pela aplicação"
  type        = string
}

variable "listener_rule_priority" {
  description = "Prioridade da regra do listener do Load Balancer"
  type        = number
}