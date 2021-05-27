output "lambda_arn" {
  value = aws_lambda_function.cw_logs_to_es.arn
}
