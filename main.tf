provider "aws" {
    region = "eu-central-1" 
}

# resource "aws_dynamodb_table" "users_table" {
#     name           = "users_table"
#     billing_mode   = "PROVISIONED"
#     read_capacity  = 20
#     write_capacity = 20
#     hash_key       = "user_hash_key"

#     attribute {
#         name = "user_hash_key"
#         type = "S"
#     }
# }



# resource "aws_iam_policy" "dynamodb_access_policy" {
#     name        = "dynamodb_access_policy"
#     description = "Allows access to DynamoDB table"
#     policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [
#         {
#             Action = [
#             "dynamodb:*"
#             ]
#             Effect   = "Allow"
#             Resource = aws_dynamodb_table.users_table.arn
#         },
#         ]
#     })
# }

# resource "aws_iam_role_policy_attachment" "attach_dynamodb_policy_to_role" {
#     role       = aws_iam_role.lambda_role.name
#     policy_arn = aws_iam_policy.dynamodb_access_policy.arn
# }

# resource "aws_dynamodb_table_item" "insert_into_users_table" {
#     table_name = aws_dynamodb_table.users_table.name

#     hash_key = "user_hash_key"
#     range_key = "example_range_key"

#     item = <<ITEM
#     {
#         "user_hash_key": {"S": "cl6ja0wmd8rru0qtfehrjl82f26h9k3t"},
#         "user_name": {"S": "Igor"}
#     }
#     ITEM
# }

resource "aws_iam_role" "lambda_role" {
    name   = "terraform_aws_lambda_role"
    assume_role_policy = jsonencode(
        {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
            }
        ]
        }
    )
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
    role        = aws_iam_role.lambda_role.name
    policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
    name        = "aws_iam_policy_for_terraform_aws_lambda_role"
    path        = "/"
    description = "AWS IAM Policy for managing aws lambda role"

    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
        {
            "Action": "*",
            "Resource": "*",
            "Effect": "Allow"
        }
        ]
    })
}



data "archive_file" "zip_handlers" {
    type        = "zip"
    source_dir  = "${path.module}/handlers/"
    output_path = "${path.module}/output/handlers.zip"
}


resource "aws_lambda_function" "connectionHandler" {
    filename = "${path.module}/output/handlers.zip"
    function_name = "connectionHandler"
    role = aws_iam_role.lambda_role.arn
    handler = "connectionHandler.handler"
    runtime = "nodejs14.x"
    depends_on = [ aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role ]
}

resource "aws_lambda_function" "getItemFromDynamodb" {
    filename = "${path.module}/output/handlers.zip"
    function_name = "getItemFromDynamodb"
    role = aws_iam_role.lambda_role.arn
    handler = "getItemFromDynamodb.handler"
    runtime = "nodejs14.x"
    depends_on = [ aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role ]
}

resource "aws_lambda_function" "getItemFromS3" {
    filename = "${path.module}/output/handlers.zip"
    function_name = "getItemFromS3"
    role = aws_iam_role.lambda_role.arn
    handler = "getItemFromS3.handler"
    runtime = "nodejs14.x"
    depends_on = [ aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role ]
}

resource "aws_api_gateway_rest_api" "connection_api_gw" {
    name = "connection_api_gw"
}

resource "aws_api_gateway_resource" "connection_resource" {
    rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
    parent_id   = aws_api_gateway_rest_api.connection_api_gw.root_resource_id
    path_part   = "users"
}

resource "aws_api_gateway_method" "connection_method" {
    rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
    resource_id = aws_api_gateway_resource.connection_resource.id
    http_method = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "connection_integration" {
    rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
    resource_id = aws_api_gateway_resource.connection_resource.id
    http_method = aws_api_gateway_method.connection_method.http_method
    integration_http_method = "POST"
    type        = "AWS_PROXY"
    uri         = aws_lambda_function.connectionHandler.invoke_arn 
}

resource "aws_lambda_permission" "apigw_lambda_permissions" {
    statement_id = "AllowExecutionFromAPIGateway"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.connectionHandler.function_name
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:eu-central-1:733374962160:${aws_api_gateway_rest_api.connection_api_gw.id}/*/${aws_api_gateway_method.connection_method.http_method}${aws_api_gateway_resource.connection_resource.path}"
}

resource "aws_api_gateway_deployment" "connection_deployment" {
    rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
    triggers = {
        redeployment = sha1(jsonencode(aws_api_gateway_integration.connection_integration))
    }

    lifecycle {
        create_before_destroy = true
    }
    depends_on = [ aws_api_gateway_method.connection_method, aws_api_gateway_integration.connection_integration ]
}

resource "aws_api_gateway_stage" "connection-stage" {
    deployment_id = aws_api_gateway_deployment.connection_deployment.id
    rest_api_id = aws_api_gateway_rest_api.connection_api_gw.id
    stage_name = "dev"
}