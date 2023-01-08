# ---- Creating a Lambda Function ----

resource "aws_lambda_function" "lambda_tf" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda.zip"
  function_name = "lambda_handler"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("lambda.zip")

  runtime = "python3.7"
  depends_on = [
    aws_iam_role.iam_for_lambda
  ]

}

# ---- Creating a IAM Role ----

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode (
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "lambda.amazonaws.com",
                    "edgelambda.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
  )
}

# ---- Creating a IAM Role Policy ----

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from lambda"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
})
}

 # ---- Associating Policy to IAM Role  ----

 resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
  depends_on = [
    aws_iam_role.iam_for_lambda,
    aws_iam_policy.lambda_logging
  ]
}

# ----Creating a CloudWatch Log Group ----
resource "aws_cloudwatch_log_group" "Lambda_log_group" {
  name = "/aws/lambda/${aws_lambda_function.lambda_tf.function_name}"
  retention_in_days = 14
  depends_on = [
    aws_lambda_function.lambda_tf
  ]
}

output "lambda-fuction-details" {
  value = aws_lambda_function.lambda_tf
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_tf.arn}"
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.API.execution_arn}/*/*/*"
  depends_on = [
        aws_lambda_function.lambda_tf,
        aws_api_gateway_rest_api.API
        ]
}

output "lambdafunction-details" {
  value = "${aws_lambda_function.lambda_tf}"
}
