output "sqs_queues" {
  value = {
    for k, v in aws_sqs_queue.main_queue :
    k => {
      arn  = v.arn
      url  = v.url
      dlq_arn = aws_sqs_queue.dlq["${k}-DLQ"].arn
    }
  }
  description = "ARNs e URLs das filas principais e suas DLQs."
}