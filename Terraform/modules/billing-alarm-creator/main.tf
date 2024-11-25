locals {
    target_email = var.target_email
    tags = {
        Name = "billing-alarm"
        Environment = "production"
        Vertical = "Security-Engineering"
        IAC = "Terraform"
    }
}

resource "aws_sns_topic" "billing_alerts" {
  name = var.billing_alerts_topic_name
  tags = local.tags
}

resource "aws_sns_topic_subscription" "billing_alerts_email" {
  topic_arn = aws_sns_topic.billing_alerts.arn
  protocol  = var.protocol
  endpoint  = local.target_email
}

resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = var.billing_alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name        = var.metric_name
  namespace          = var.namespace
  period             = var.period
  statistic          = var.statistic
  threshold          = var.threshold

  alarm_description = "This alarm monitors AWS billing and sends notifications if charges exceed the threshold."
  alarm_actions     = [aws_sns_topic.billing_alerts.arn]

  tags = local.tags
}
