################################################################################################    Lambda



# resource "aws_lambda_function" "connectionHandler" {
#     filename = "${path.module}/output/handlers.zip"
#     function_name = "connectionHandler"
#     role = aws_iam_role.lambda_role.arn
#     handler = "connectionHandler.handler"
#     runtime = "nodejs16.x"
#     depends_on = [ aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role ]
# }

# resource "aws_lambda_function" "getItemFromDynamodb" {
#     filename = "${path.module}/output/handlers.zip"
#     function_name = "getItemFromDynamodb"
#     role = aws_iam_role.lambda_role.arn
#     handler = "getItemFromDynamodb.handler"
#     runtime = "nodejs16.x"
#     depends_on = [ aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role ]
# }

# resource "aws_lambda_function" "getItemFromS3" {
#     filename = "${path.module}/output/handlers.zip"
#     function_name = "getItemFromS3"
#     role = aws_iam_role.lambda_role.arn
#     handler = "getItemFromS3.handler"
#     runtime = "nodejs16.x"
#     depends_on = [ aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role ]
# }

# resource "aws_lambda_function" "errorHandler" {
#     filename = "${path.module}/output/handlers.zip"
#     function_name = "errorHandler"
#     role = aws_iam_role.lambda_role.arn
#     handler = "errorHandler.handler"
#     runtime = "nodejs16.x"
#     depends_on = [ aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role ]
# }

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/throw400"
  retention_in_days = 14
}

resource "aws_lambda_function" "throw400" {
    filename = "${path.module}/output/handlers.zip"
    function_name = "throw400"
    role = aws_iam_role.lambda_role.arn
    handler = "throw400.handler"
    runtime = "nodejs16.x"

    depends_on = [
        aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role
    ]
}