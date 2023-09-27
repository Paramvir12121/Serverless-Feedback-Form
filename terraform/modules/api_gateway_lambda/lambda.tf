resource "aws_lambda_function" "restapi-connected-function" {
  filename      = var.lambda_filename
  function_name = "feedabck-lambda"
  role          = aws_iam_role.lambda-iam.arn
  handler       = "main.lambda_handler"
  runtime       = var.runtime
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

# resource "aws_lambda_invocation" "example" {
#   function_name = aws_lambda_function.lambda_function_test.function_name

#   input = jsonencode({
#     key1 = "value1"
#     key2 = "value2"
#   })
# }

# output "result_entry" {
#   value = jsondecode(aws_lambda_invocation.example.result)["key1"]
# }


