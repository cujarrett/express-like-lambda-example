resource "aws_api_gateway_rest_api" "express-like-lambda-example" {
  name = "express-like-lambda-example"
}

resource "aws_api_gateway_method" "proxy-root" {
  rest_api_id   = aws_api_gateway_rest_api.express-like-lambda-example.id
  resource_id   = aws_api_gateway_rest_api.express-like-lambda-example.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "express-like-lambda-example" {
  rest_api_id             = aws_api_gateway_rest_api.express-like-lambda-example.id
  resource_id             = aws_api_gateway_method.proxy-root.resource_id
  http_method             = aws_api_gateway_method.proxy-root.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.aws-lambda-function-express-like-lambda-example-invoke-arn
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.express-like-lambda-example.id
  parent_id   = aws_api_gateway_rest_api.express-like-lambda-example.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.express-like-lambda-example.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = aws_api_gateway_rest_api.express-like-lambda-example.id
  resource_id             = aws_api_gateway_method.proxy.resource_id
  http_method             = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.aws-lambda-function-express-like-lambda-example-invoke-arn
}

resource "aws_api_gateway_deployment" "express-like-lambda-example_v1" {
  depends_on = [
    aws_api_gateway_integration.express-like-lambda-example
  ]
  rest_api_id = aws_api_gateway_rest_api.express-like-lambda-example.id
  stage_name  = "v1"
}

output "endpoint" {
  value = aws_api_gateway_deployment.express-like-lambda-example_v1.invoke_url
}
