resource "aws_cloudwatch_event_rule" "s3bucketcheck_schedule" {
    name = "s3BucketCheckSchedule"
    description = "Scheduled S3BucketCheck (Daily)"
    schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "s3bucketcheck_schedule" {
    rule = "${aws_cloudwatch_event_rule.s3bucketcheck_schedule.name}"
    target_id = "s3bucketcheck"
    arn = "${aws_lambda_function.lambda_s3bucketcheck.arn}"
}
