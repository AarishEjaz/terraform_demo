output "alarm_arn" {
    value = aws_cloudwatch_metric_alarm.cloudwatch_alarm
}

output "alarm_id" {
    value = aws_cloudwatch_metric_alarm.cloudwatch_alarm.id
}