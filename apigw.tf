################################################################################################    ApiGateway

# resource "aws_api_gateway_rest_api" "connection_api_gw" {
#     name = "connection_api_gw"
# }

# # users
# resource "aws_api_gateway_resource" "user_resource" {
#     rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
#     parent_id   = aws_api_gateway_rest_api.connection_api_gw.root_resource_id
#     path_part   = "users"
# }

# # users/{user}
# resource "aws_api_gateway_resource" "user_id_resource" {
#     rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
#     parent_id   = aws_api_gateway_resource.user_resource.id
#     path_part   = "{user}"
# }

# resource "aws_api_gateway_method" "connection_method" {
#     rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
#     resource_id = aws_api_gateway_resource.user_id_resource.id
#     http_method = "GET"
#     authorization = "NONE"
#     request_parameters = {
#         "method.request.path.user" = true
#     }
# }

# resource "aws_api_gateway_integration" "connection_integration" {
#     rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
#     resource_id = aws_api_gateway_resource.user_id_resource.id
#     http_method = aws_api_gateway_method.connection_method.http_method
#     integration_http_method = "POST"
#     type        = "AWS_PROXY"
#     uri         = aws_lambda_function.connectionHandler.invoke_arn 
# }

# resource "aws_lambda_permission" "apigw_lambda_permissions" {
#     statement_id = "AllowExecutionFromAPIGateway"
#     action = "lambda:InvokeFunction"
#     function_name = aws_lambda_function.connectionHandler.function_name
#     principal = "apigateway.amazonaws.com"
#     source_arn = "arn:aws:execute-api:eu-central-1:733374962160:${aws_api_gateway_rest_api.connection_api_gw.id}/*/${aws_api_gateway_method.connection_method.http_method}${aws_api_gateway_resource.user_id_resource.path}"
# }

# resource "aws_api_gateway_deployment" "connection_deployment" {
#     rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
#     triggers = {
#         redeployment = sha1(jsonencode(aws_api_gateway_integration.connection_integration))
#     }

#     lifecycle {
#         create_before_destroy = true
#     }
#     depends_on = [ aws_api_gateway_method.connection_method, aws_api_gateway_integration.connection_integration ]
# }

# resource "aws_api_gateway_stage" "connection-stage" {
#     deployment_id = aws_api_gateway_deployment.connection_deployment.id
#     rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
#     stage_name = "dev"
# }

