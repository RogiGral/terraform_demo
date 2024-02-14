# ################################################################################################    S3 Bucket

# resource "aws_s3_bucket" "user_logs_s3_bucket" {
#     bucket        = "user-logs-s3-bucket-dev"
#     force_destroy = true
#     tags          = {
#         Name        = "user-logs-s3-bucket-dev"
#         Environment = "dev"
#     }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "user_logs_s3_bucket_config" {
#     bucket = aws_s3_bucket.user_logs_s3_bucket.id

#     rule {
#         apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#         }
#     }
# }

# resource "aws_s3_bucket_public_access_block" "user_logs_s3_bucket_access_block" {
#     bucket = aws_s3_bucket.user_logs_s3_bucket.id

#     block_public_acls       = true
#     ignore_public_acls      = true
#     block_public_policy     = true
#     restrict_public_buckets = true
# }

# resource "aws_s3_bucket_versioning" "user_logs_s3_bucket" {
#     bucket = aws_s3_bucket.user_logs_s3_bucket.id
#     versioning_configuration {
#         status = "Enabled"
#     }
# }

# resource "aws_s3_object" "user1_file1" {
#     bucket = aws_s3_bucket.user_logs_s3_bucket.id
#     key    = "cl6ja0wmd8rru0qtfehrjl82f26h9k3t/file1.txt"
#     server_side_encryption = "AES256"
#     source = "files/file1.txt"
# }

# resource "aws_s3_object" "user1_file2" {
#     bucket = aws_s3_bucket.user_logs_s3_bucket.id
#     key    = "cl6ja0wmd8rru0qtfehrjl82f26h9k3t/file2.txt"
#     server_side_encryption = "AES256"
#     source = "files/file2.txt"
# }

# resource "aws_s3_object" "user2_no_file" {
#     bucket = aws_s3_bucket.user_logs_s3_bucket.id
#     key = "o0fru9zq9s4rldkygx0mb1sdqgp3ih6o/"
#     server_side_encryption = "AES256"
# }
