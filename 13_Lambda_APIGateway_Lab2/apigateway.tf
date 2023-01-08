resource "aws_api_gateway_rest_api" "API" {
  name        = "My_API"
  description = "This is my API to trigger lambda"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.API.id
  parent_id   = aws_api_gateway_rest_api.API.root_resource_id
  path_part   = "resource"
  depends_on = [
    aws_api_gateway_rest_api.API
  ]
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${aws_api_gateway_rest_api.API.id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method   = "GET"
  authorization = "NONE"
  depends_on = [
              aws_api_gateway_rest_api.API,
              aws_api_gateway_resource.resource
              ]
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.API.id}"
  resource_id             = "${aws_api_gateway_resource.resource.id}"
  http_method             = "${aws_api_gateway_method.method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "${aws_lambda_function.lambda_tf.invoke_arn}"
  depends_on = [
                aws_api_gateway_rest_api.API,
                aws_api_gateway_resource.resource,
                aws_api_gateway_method.method
                ]
  }

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = "${aws_api_gateway_rest_api.API.id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.method.http_method}"
  status_code = "200"
  
  response_models = {
         "application/json" = "Empty"
    }
  depends_on = [
            aws_api_gateway_resource.resource,
            aws_api_gateway_rest_api.API,
            aws_api_gateway_method.method
            ]
}


resource "aws_api_gateway_integration_response" "MyDemoIntegrationResponse" {
  rest_api_id = "${aws_api_gateway_rest_api.API.id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.method.http_method}"
  status_code = "${aws_api_gateway_method_response.response_200.status_code}"
   
  depends_on = [
        aws_api_gateway_resource.resource,
        aws_api_gateway_rest_api.API,
        aws_api_gateway_method_response.response_200,
        aws_api_gateway_method.method,
        aws_api_gateway_integration.integration
        ]
}

resource "aws_api_gateway_deployment" "example" {
  
  rest_api_id = "${aws_api_gateway_rest_api.API.id}"
  stage_name  = "test"

  depends_on = [
        aws_api_gateway_integration.integration
        ]
}

output "deployment-url" {
  value = "${aws_api_gateway_deployment.example.invoke_url}"
}
