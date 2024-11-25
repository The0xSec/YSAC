variable "billing_alarm_name" {
  description = "The name of the billing alarm."
  type        = string
}

variable "comparison_operator" {
  description = "The comparison operator to use when comparing the metric value to the threshold."
  type        = string
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the threshold."
  type        = number
}

variable "metric_name" {
  description = "The name of the metric to monitor."
  type        = string
}

variable "namespace" {
  description = "The namespace of the metric to monitor."
  type        = string
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied."
  type        = number
}

variable "statistic" {
  description = "The statistic to apply to the metric."
  type        = string
}

variable "threshold" {
  description = "The value against which the specified statistic is compared."
  type        = number
}

variable "protocol" {
  description = "The protocol to use when sending notifications."
  type        = string
}

variable "target_email" {
  description = "The email address to notify when the alarm is triggered."
  type        = string
}

variable "billing_alerts_topic_name" {
  description = "The name of the SNS topic to create for billing alerts."
  type        = string
}