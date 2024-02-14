################################################################################################    SNS

resource "aws_sns_topic" "notification_topic" {
    name = "notification_topic"
}

resource "aws_sns_topic_subscription" "notification_topic_subscription" {
    topic_arn = aws_sns_topic.notification_topic.arn
    protocol  = "email"
    endpoint  = "mreriker8@gmail.com"
}