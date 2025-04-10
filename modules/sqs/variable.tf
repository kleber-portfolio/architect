variable "queues" {
  type = list(object({
    name              = string
    max_receive_count = number
  }))
  description = "Lista de filas SQS com seus nomes e configurações de redrive."
}