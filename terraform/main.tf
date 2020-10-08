module "archive" {
  source = "./modules/archive"
}

module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source = "./modules/lambda"
  data-archive-file-placeholder-output-path = module.archive.data-archive-file-placeholder-output-path
  aws-iam-role-express-like-lambda-example-arn = module.iam.aws-iam-role-express-like-lambda-example-arn
}

module "api-gateway" {
  source = "./modules/api-gateway"
  aws-lambda-function-express-like-lambda-example-arn = module.lambda.aws-lambda-function-express-like-lambda-example-arn
  aws-lambda-function-express-like-lambda-example-invoke-arn = module.lambda.aws-lambda-function-express-like-lambda-example-invoke-arn
}

# Set the generated URL as an output. Run `terraform output url` to get this.
output "endpoint" {
  value = module.api-gateway.endpoint
}
