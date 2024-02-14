################################################################    Lambda IAM Policy

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

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
    role        = aws_iam_role.lambda_role.name
    policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

# ################################################################   StepFunctions IAM Policy

# resource "aws_iam_role" "stepfunctions_role" {
#     name = "terraform_aws_stepfunctions_role"

#     assume_role_policy = jsonencode({
#         "Version": "2012-10-17",
#         "Statement": [
#             {
#             "Sid": "",
#             "Effect": "Allow",
#             "Principal": {
#                 "Service": "states.amazonaws.com"
#             },
#             "Action": "sts:AssumeRole"
#             }
#         ]
#     })
# }

# resource "aws_iam_policy" "stepfunctions_policy" {
#     name = "aws_iam_policy_for_terraform_aws_stepfunctions_policy"

#     policy = jsonencode({
#         "Version": "2012-10-17",
#         "Statement": [
#         {
#             "Action": "*",
#             "Resource": "*",
#             "Effect": "Allow"
#         }
#         ]
#     })
# }

# resource "aws_iam_role_policy_attachment" "stepfunctions_attachment" {
#     role       = aws_iam_role.stepfunctions_role.name
#     policy_arn = aws_iam_policy.stepfunctions_policy.arn
# }

################################################################    DynamoDB IAM Policy

# resource "aws_iam_role" "dynamodb_role" {
#     name   = "terraform_aws_dynamodb_role"
#     assume_role_policy = jsonencode(
#         {
#         "Version": "2012-10-17",
#         "Statement": [
#             {
#             "Action": "sts:AssumeRole",
#             "Principal": {
#                 "Service": "dynamodb.amazonaws.com"
#             },
#             "Effect": "Allow",
#             "Sid": ""
#             }
#         ]
#         }
#     )
# }

# resource "aws_iam_policy" "dynamodb_access_policy" {
#     name        = "aws_iam_policy_for_terraform_aws_dynamodb_access_policy"
#     description = "Allows access to DynamoDB table"
#     policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [
#         {
#             Action = [
#             "dynamodb:*"
#             ]
#             Effect   = "Allow"
#             Resource = aws_dynamodb_table.usersTable.arn
#         },
#         ]
#     })
# }

# resource "aws_iam_role_policy_attachment" "attach_dynamodb_policy_to_role" {
#     role       = aws_iam_role.dynamodb_role.name
#     policy_arn = aws_iam_policy.dynamodb_access_policy.arn
# }