resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = var.api_gateway_name
  description = var.api_gateway_description
}

resource "aws_api_gateway_resource" "api_resource_feedback" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "feedback"
}

resource "aws_api_gateway_method" "api_method_feedback" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_resource_feedback.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_intigration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_resource_feedback.id
  http_method             = aws_api_gateway_method.api_method_feedback.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.restapi-connected-function.invoke_arn
  # passthrough_behavior = "WHEN_NO_MATCH"
}


# resource "aws_api_gateway_deployment" "api_deployment" {
#   depends_on  = [aws_api_gateway_integration.api_intigration]
#   rest_api_id = aws_api_gateway_rest_api.api_gateway.id
#   stage_name  = "dev" # Change to your desired stage name
# }

output "api_gateway_url" {
  value = aws_api_gateway_deployment.feedback.invoke_url
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.restapi-connected-function.arn
  principal     = "apigateway.amazonaws.com"
  #source_arn    = "arn:aws:execute-api:${var.region}:${var.accountId}:${aws_api_gateway_rest_api.api_gateway.id}/*/${aws_api_gateway_method.api_method_feedback.http_method}${aws_api_gateway_resource.api_resource_feedback.path}"
  source_arn = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*"
}


resource "aws_api_gateway_deployment" "feedback" {
  depends_on  = [aws_api_gateway_integration.api_intigration]
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id

  triggers = {
    redeployment = sha1(jsonencode([aws_api_gateway_integration.api_intigration.id]))
    # aws_api_gateway_resource.api_resource_feedback.id
    # aws_api_gateway_method.api_method_feedback.id,
    # aws_api_gateway_integration.api_intigration.id,
    # ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "name" {
  deployment_id = aws_api_gateway_deployment.feedback.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  stage_name    = "test"

}