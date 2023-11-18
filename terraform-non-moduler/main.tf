provider "aws" {
  region = "us-west-2" # Change to your preferred region
}

# Assuming the DynamoDB table and S3 bucket are already created and configured

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
    }]
  })
}

# IAM policy to allow Lambda to access DynamoDB
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy"
  description = "IAM policy for Lambda to interact with DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem"
      ],
      Effect   = "Allow",
      Resource = "arn:aws:dynamodb:<region>:<account-id>:table/<your-table-name>" # Replace <region>, <account-id>, and <your-table-name> appropriately
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Lambda function
resource "aws_lambda_function" "feedback_lambda" {
  function_name = "feedbackFunction"

  # ... (Specify lambda configuration including runtime, handler, and the S3 bucket/key for your deployment package)

  role = aws_iam_role.lambda_role.arn
}

# API Gateway
resource "aws_api_gateway_rest_api" "feedback_api" {
  name        = "FeedbackAPI"
  description = "API for feedback form"
}

# Lambda permission
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.feedback_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # Source arn for API Gateway
  source_arn = "${aws_api_gateway_rest_api.feedback_api.execution_arn}/*/*/*"
}

# More API Gateway resources (methods, integrations, etc.) will be required here
