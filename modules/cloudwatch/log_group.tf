resource "aws_cloudwatch_log_group" "api_gw_logs" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
}


output "api_log_group_arn" {
    value = aws_cloudwatch_log_group.api_gw_logs.arn
}