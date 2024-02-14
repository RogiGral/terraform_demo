################################################################################################    Lambda alarms

//&& $.data.message = 'lambda response' && ($.data.body.code = 'dev-lyr-dama-2' || $.data.body.code = 'dev-lyr-dama-3' || $.data.body.code = 'dev-ept-com-1' || $.data.body.code = 'dev-ept-com-2' || $.data.body.code = 'dev-ept-ruco-1' || $.data.body.code = 'dev-ept-ruco-2' || $.data.body.code = 'dev-ept-deda-1' || $.data.body.code = 'dev-ept-deda-2' || $.data.body.code = 'dev-ept-hest-1' || $.data.body.code = 'dev-ept-seli-1' || $.data.body.code = 'dev-ept-avfw-1')
resource "aws_cloudwatch_metric_alarm" "lambda_throw4xx_metric_alarm" {
    alarm_name          = "Lambda4xxErrorAlarm"
    alarm_description   = "Lambda4xxErrorAlarm"

    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "1"
    threshold           = "30"
    treat_missing_data  = "notBreaching"
    datapoints_to_alarm = 1
    metric_name = "4xxAlarm"
    namespace   = "LambdaErrorMetric"
    statistic = "Sum"
    period      = 300
    unit        = "Count"
    actions_enabled = true
    alarm_actions = [
        aws_sns_topic_subscription.notification_topic_subscription.arn
    ]
    ok_actions = []
    insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "lambda_throw4xx_metric_alarm_test" {
    alarm_name          = "Lambda4xxErrorAlarmTest"
    alarm_description   = "Lambda4xxErrorAlarmTest"

    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "1"
    threshold           = "30"
    treat_missing_data  = "notBreaching"
    datapoints_to_alarm = 1
    metric_name = "4xxAlarmTest"
    namespace   = "LambdaErrorMetric"
    statistic = "Sum"
    period      = 300
    unit        = "Count"
    actions_enabled = true
    alarm_actions = [
        aws_sns_topic_subscription.notification_topic_subscription.arn
    ]
    ok_actions = []
    insufficient_data_actions = []
}

resource "aws_cloudwatch_log_metric_filter" "api_4xx_metric_filter" {
    name           = "api_4xx_metric_filter"
    pattern        = "{$.message.data.statusCode >= 400 && $.message.data.statusCode<500}"
    log_group_name = "/aws/lambda/throw400"

    metric_transformation {
        name      = "4xxAlarm"
        namespace = "LambdaErrorMetric"
        value     = "1"
        unit       = "Seconds"
    }
}
resource "aws_cloudwatch_log_metric_filter" "api_4xx_metric_filter_test" {
    name           = "api_4xx_metric_filter_test"
    pattern        = "{$.message.data.statusCode >= 400 && $.message.data.statusCode<500}"
    log_group_name = "/aws/lambda/throw400"

    metric_transformation {
        name      = "4xxAlarmTest"
        namespace = "LambdaErrorMetric"
        value     = "1"
        unit       = "Seconds"
    }
}


