resource "aws_apigatewayv2_api" "api" {
  name          = "demo_api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "api_int" {
  api_id             = aws_apigatewayv2_api.api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = var.lambda_invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}
 
resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = var.route_key
  target    = "integrations/${aws_apigatewayv2_integration.api_int.id}"
}
 
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw_logs.arn
    format = jsonencode({
      requestId = "$context.requestId"
    })
  }

  default_route_settings {
    logging_level       = "INFO"
    data_trace_enabled  = true
  }
}

 
resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewaytoInvokelambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}

# log group
resource "aws_cloudwatch_log_group" "api_gw_logs" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
}


output "api_log_group_arn" {
    value = aws_cloudwatch_log_group.api_gw_logs.arn
}