module "iam" {
    source = "./modules/iam"
    role_name = "lambda_execution_role"
}

module "lambda" {
    source = "./modules/lambda"
    image_uri  = "058264249757.dkr.ecr.ap-south-1.amazonaws.com/demo:latest"
    role_arn = module.iam.role_arn
}

module "api" {
    source = "./modules/api"
    route_key = "GET /hello"
    lambda_invoke_arn = module.lambda.invoke_arn
    lambda_arn = module.lambda.arn
}

module "cloudwatch" {
    source = "./modules/api"
    log_group_name = "demo_api_cloudwatch_log_group"
    retention_in_days = 7

}