resource "aws_lambda_function" "demo" {
  function_name = "hello_demo_uc7"
  package_type  = "Image"
  image_uri     = var.image_uri
  role          = var.role_arn
  timeout       = 15
}