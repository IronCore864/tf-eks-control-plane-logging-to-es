data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name               = "LambdaExecutionRoleToES"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "es" {
  statement {
    effect    = "Allow"
    actions   = ["es:*"]
    resources = ["${var.elasticsearch_domain_arn}/*"]
  }
}

resource "aws_iam_policy" "es" {
  name   = "LambdaExecutionRoleToESPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.es.json
}

resource "aws_iam_role_policy_attachment" "es" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.es.arn
}

resource "aws_iam_role_policy_attachment" "vpc_execution_role" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
