resource "aws_cloudwatch_log_group" "api_gw_logs" {
  name              = "demo_api_cloudwatch_log_group"
  retention_in_days = 7
}

output "api_log_group_arn" {
    value = aws_cloudwatch_log_group.api_gw_logs.arn
}