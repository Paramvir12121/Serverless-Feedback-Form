resource "aws_lambda_function" "lambda" {
  filename         = "lambda"
  function_name    = "feedback"
  role             = aws_iam_role.lambda-iam.arn
  handler          = var.handler
  runtime          = var.runtime
  source_code_hash = var.source_code_hash
}

resource "aws_iam_role" "lambda-iam" {
  name               = "lambda-iam"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}