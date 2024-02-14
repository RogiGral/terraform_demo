################################################################################################    Step Functions

# resource "aws_sfn_state_machine" "state_machine" {
#     name     = "state_machine"
#     definition =  jsonencode(
#     {
#     "Comment": "A description of my state machine",
#     "StartAt": "Try",
#     "States": {
#         "ErrorHandler": {
#             "Next": "NotifyError",
#             "Resource": "arn:aws:lambda:eu-central-1:733374962160:function:errorHandler:$LATEST",
#             "ResultSelector": {
#                 "errorCode.$": "$.statusCode",
#                 "errorType.$": "$.body.errorType",
#                 "errorMessage.$": "$.body.errorMessage"
#             },
#             "Type": "Task"
#         },
#         "NotifyError": {
#             "Next": "FailWorkflow",
#             "Parameters": {
#                 "TopicArn": "arn:aws:sns:eu-central-1:733374962160:notification_topic",
#                 "Message.$": "$"
#             },
#             "Resource": "arn:aws:states:::sns:publish",
#             "Type": "Task",
#             "ResultPath": null
#         },
#         "FailWorkflow": {
#             "Type": "Fail"
#         },
#         "Try": {
#         "Branches": [
#             {
#             "StartAt": "GetUserFromDynamoDb",
#             "States": {

#                 "GetUserFromDynamoDb": {
#                     "Next": "GetUserErrorFilesFromS3",
#                     "Parameters": {
#                         "user.$": "$.user"
#                     },
#                     "Resource": "arn:aws:lambda:eu-central-1:733374962160:function:getItemFromDynamodb:$LATEST",
#                     "ResultPath": "$.dataFromDynamo",
#                     "Retry": [
#                         {
#                         "BackoffRate": 2,
#                         "ErrorEquals": [
#                             "Lambda.ServiceException",
#                             "Lambda.AWSLambdaException",
#                             "Lambda.SdkClientException",
#                             "Lambda.TooManyRequestsException"
#                         ],
#                         "IntervalSeconds": 1,
#                         "MaxAttempts": 3
#                         }
#                     ],
#                     "Type": "Task"
#                 },

#                 "GetUserErrorFilesFromS3": {
#                     "Next": "Choice",
#                     "Parameters": {
#                         "dataFromDynamo.$": "$.dataFromDynamo",
#                         "user.$": "$.user"
#                     },
#                     "Resource": "arn:aws:lambda:eu-central-1:733374962160:function:getItemFromS3:$LATEST",
#                     "ResultPath": "$.dataFromS3",
#                     "Retry": [
#                         {
#                         "BackoffRate": 2,
#                         "ErrorEquals": [
#                             "Lambda.ServiceException",
#                             "Lambda.AWSLambdaException",
#                             "Lambda.SdkClientException",
#                             "Lambda.TooManyRequestsException"
#                         ],
#                         "IntervalSeconds": 1,
#                         "MaxAttempts": 3
#                         }
#                     ],
#                     "Type": "Task"
#                 },

#                 "Choice": {
#                     "Choices": [
#                         {
#                         "Next": "NotifySuccess",
#                         "NumericGreaterThan": 0,
#                         "Variable": "$.dataFromS3.numberOfFiles"
#                         }
#                     ],
#                     "Default": "NotifyFailure",
#                     "Type": "Choice"
#                 },

                
#                 "NotifyFailure": {
#                     "End": true,
#                     "Parameters": {
#                         "Message.$": "$",
#                         "TopicArn": "arn:aws:sns:eu-central-1:733374962160:notification_topic"
#                     },
#                     "Resource": "arn:aws:states:::sns:publish",
#                     "Type": "Task",
#                     "ResultPath": null
#                 },
#                 "NotifySuccess": {
#                     "End": true,
#                     "Parameters": {
#                         "Message.$": "$",
#                         "TopicArn": "arn:aws:sns:eu-central-1:733374962160:notification_topic"
#                     },
#                     "Resource": "arn:aws:states:::sns:publish",
#                     "Type": "Task",
#                     "ResultPath": null
#                 }
#             }
#             }
#         ],
#         "Catch": [
#             {
#             "ErrorEquals": [
#                 "States.ALL"
#             ],
#             "Next": "ErrorHandler"
#             }
#         ],
#         "End": true,
#         "Type": "Parallel"
#         }
#     }
# })
#     role_arn = aws_iam_role.stepfunctions_role.arn
# }

