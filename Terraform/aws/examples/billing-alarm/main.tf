module "billing_alarm" {
  source = "../../../modules/billing-alarm-creator"

  billing_alarm_name = "billing-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "EstimatedCharges"
  namespace = "AWS/Billing"
  period = 21600
  statistic = "Maximum"
  threshold = 10 # $10
  protocol = "email"
  target_email = "the0xsec@gmail.com"
  billing_alerts_topic_name = "billing-alerts"
  
}