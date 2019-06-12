/**
* ## Modules: aws/alarm/alb
*
* This module creates the following CloudWatch alarms in the
* AWS/ApplicationELB namespace:
*
*   - HTTPCode_Target_4XX_Count greater than or equal to threshold
*   - HTTPCode_Target_5XX_Count greater than or equal to threshold
*   - HTTPCode_ELB_4XX_Count greater than or equal to threshold
*   - HTTPCode_ELB_5XX_Count greater than or equal to threshold
*
* All metrics are measured during a period of 60 seconds and evaluated
* during 5 consecutive periods.
*
* To disable any alarm, set the threshold parameter to 0.
*
* AWS/ApplicationELB metrics reference:
*
* http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/elb-metricscollected.html#load-balancer-metric-dimensions-alb
*/
variable "name_prefix" {
  type        = "string"
  description = "The alarm name prefix."
}

variable "alarm_actions" {
  type        = "list"
  description = "The list of actions to execute when this alarm transitions into an ALARM state. Each action is specified as an Amazon Resource Number (ARN)."
  default     = []
}

variable "alb_arn_suffix" {
  type        = "string"
  description = "The ALB ARN suffix for use with CloudWatch Metrics."
}

variable "httpcode_target_4xx_count_threshold" {
  type        = "string"
  description = "The value against which the HTTPCode_Target_4XX_Count metric is compared."
  default     = "0"
}

variable "httpcode_target_5xx_count_threshold" {
  type        = "string"
  description = "The value against which the HTTPCode_Target_5XX_Count metric is compared."
  default     = "80"
}

variable "httpcode_elb_4xx_count_threshold" {
  type        = "string"
  description = "The value against which the HTTPCode_ELB_4XX_Count metric is compared."
  default     = "0"
}

variable "httpcode_elb_5xx_count_threshold" {
  type        = "string"
  description = "The value against which the HTTPCode_ELB_5XX_Count metric is compared."
  default     = "80"
}

# Resources
#--------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "elb_httpcode_elb_4xx_count" {
  count               = "${var.httpcode_elb_4xx_count_threshold > 0 ? 1 : 0}"
  alarm_name          = "${var.name_prefix}-elb-httpcode_elb_4xx_count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "${var.httpcode_elb_4xx_count_threshold}"
  actions_enabled     = true
  alarm_actions       = ["${var.alarm_actions}"]
  alarm_description   = "This metric monitors the sum of HTTP 4XX response codes generated by the Application LB."
  treat_missing_data  = "notBreaching"

  dimensions {
    LoadBalancer = "${var.alb_arn_suffix}"
  }
}

resource "aws_cloudwatch_metric_alarm" "elb_httpcode_elb_5xx_count" {
  count               = "${var.httpcode_elb_5xx_count_threshold > 0 ? 1 : 0}"
  alarm_name          = "${var.name_prefix}-elb-httpcode_elb_5xx_count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "${var.httpcode_elb_5xx_count_threshold}"
  actions_enabled     = true
  alarm_actions       = ["${var.alarm_actions}"]
  alarm_description   = "This metric monitors the sum of HTTP 5XX response codes generated by the Application LB."
  treat_missing_data  = "notBreaching"

  dimensions {
    LoadBalancer = "${var.alb_arn_suffix}"
  }
}

resource "aws_cloudwatch_metric_alarm" "elb_httpcode_target_4xx_count" {
  count               = "${var.httpcode_target_4xx_count_threshold > 0 ? 1 : 0}"
  alarm_name          = "${var.name_prefix}-elb-httpcode_target_4xx_count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "${var.httpcode_target_4xx_count_threshold}"
  actions_enabled     = true
  alarm_actions       = ["${var.alarm_actions}"]
  alarm_description   = "This metric monitors the sum of HTTP 4XX response codes generated by the Target Groups."
  treat_missing_data  = "notBreaching"

  dimensions {
    LoadBalancer = "${var.alb_arn_suffix}"
  }
}

resource "aws_cloudwatch_metric_alarm" "elb_httpcode_target_5xx_count" {
  count               = "${var.httpcode_target_5xx_count_threshold > 0 ? 1 : 0}"
  alarm_name          = "${var.name_prefix}-elb-httpcode_target_5xx_count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "${var.httpcode_target_5xx_count_threshold}"
  actions_enabled     = true
  alarm_actions       = ["${var.alarm_actions}"]
  alarm_description   = "This metric monitors the sum of HTTP 5XX response codes generated by the Target Groups."
  treat_missing_data  = "notBreaching"

  dimensions {
    LoadBalancer = "${var.alb_arn_suffix}"
  }
}

# Outputs
#--------------------------------------------------------------

