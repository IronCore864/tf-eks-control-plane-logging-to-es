data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "index.js"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "cw_logs_to_es" {
  filename         = "lambda_function_payload.zip"
  function_name    = "EKSControlPlaneLoggingToES_${var.eks_cluster_name}"
  role             = aws_iam_role.lambda.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "nodejs10.x"
}

resource "aws_lambda_permission" "logging" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cw_logs_to_es.function_name
  principal     = "logs.${var.eks_region}.amazonaws.com"
  source_arn    = var.log_group_arn
}
