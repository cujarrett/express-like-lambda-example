resource "aws_lambda_function" "express-like-lambda-example" {
  filename = var.data-archive-file-placeholder-output-path
  function_name = "express-like-lambda-example"
  handler       = "index.handler"
  role          = var.aws-iam-role-express-like-lambda-example-arn
  runtime       = "nodejs12.x"
  memory_size   = 128
  timeout       = 1
}

resource "aws_lambda_function_event_invoke_config" "express-like-lambda-example-event-invoke-config" {
  function_name = aws_lambda_function.express-like-lambda-example.arn
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 0
}

resource "aws_lambda_permission" "express-like-lambda-example" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.express-like-lambda-example.arn
  principal     = "apigateway.amazonaws.com"
}

output "aws-lambda-function-express-like-lambda-example-arn" {
  value = aws_lambda_function.express-like-lambda-example.arn
}

output "aws-lambda-function-express-like-lambda-example-invoke-arn" {
  value = aws_lambda_function.express-like-lambda-example.invoke_arn
}
