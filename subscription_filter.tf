resource "aws_cloudwatch_log_subscription_filter" "logfilter" {
  depends_on = [
    aws_lambda_permission.logging
  ]

  name           = "all"
  log_group_name = var.log_group_name
  # matches all
  filter_pattern  = ""
  destination_arn = aws_lambda_function.cw_logs_to_es.arn
}
