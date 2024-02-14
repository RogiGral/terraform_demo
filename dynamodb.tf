# ################################################################################################    DynamoDB


# resource "aws_dynamodb_table" "usersTable" {
#     name           = "usersTable"
#     billing_mode   = "PROVISIONED"
#     read_capacity  = 20
#     write_capacity = 20
#     hash_key       = "userId"

#     attribute {
#         name = "userId"
#         type = "S"
#     }
# }


# resource "aws_dynamodb_table_item" "insert_user_1" {
#     table_name = aws_dynamodb_table.usersTable.name

#     hash_key = "userId"

#     item = <<ITEM
#     {
#         "userId": {"S": "cl6ja0wmd8rru0qtfehrjl82f26h9k3t"},
#         "userName": {"S": "Igor"}
#     }
#     ITEM
# }

# resource "aws_dynamodb_table_item" "insert_user_2" {
#     table_name = aws_dynamodb_table.usersTable.name

#     hash_key = "userId"

#     item = <<ITEM
#     {
#         "userId": {"S": "o0fru9zq9s4rldkygx0mb1sdqgp3ih6o"},
#         "userName": {"S": "Anonimous"}
#     }
#     ITEM
# }

