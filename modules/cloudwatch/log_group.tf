resource "aws_cloudwatch_log_group" "api_gw_logs" {
  name              = var.log_group_name
  retention_in_days = 7
}


variable "log_group_name" {}