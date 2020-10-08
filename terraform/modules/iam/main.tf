resource "aws_iam_role" "express-like-lambda-example" {
  name               = "express-like-lambda-example"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "lambda.amazonaws.com"
    },
    "Effect": "Allow"
  }
}
POLICY
}

resource "aws_iam_policy" "express-like-lambda-example-logs" {
  name        = "express-like-lambda-example-logs"
  description = "Adds logging access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach-logs" {
  role       = aws_iam_role.express-like-lambda-example.name
  policy_arn = aws_iam_policy.express-like-lambda-example-logs.arn
}

output "aws-iam-role-express-like-lambda-example-arn" {
  value = aws_iam_role.express-like-lambda-example.arn
}
