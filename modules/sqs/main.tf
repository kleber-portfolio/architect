resource "aws_sqs_queue" "dlq" {
  for_each = {
    for q in var.queues : "${q.name}-DLQ" => q
  }

  name = each.key
}

resource "aws_sqs_queue" "main_queue" {
  for_each = {
    for q in var.queues : q.name => q
  }

  name = each.key

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq["${each.key}-DLQ"].arn
    maxReceiveCount     = each.value.max_receive_count
  })
}