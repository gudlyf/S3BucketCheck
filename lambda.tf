resource "aws_lambda_function" "lambda_s3bucketcheck" {
  filename         = "s3bucketcheck_payload.zip"
  function_name    = "S3BucketCheck"
  description      = "Report on S3 buckets with public/all-users permissions"
  role             = "${aws_iam_role.iam_for_lambda_s3bucketcheck.arn}"
  handler          = "s3bucketcheck.lambda_handler"
  timeout          = 30
  source_code_hash = "${base64sha256(file("s3bucketcheck_payload.zip"))}"
  runtime          = "python2.7"

  environment {
    variables = {
      sns_arn = "${aws_sns_topic.sns_s3bucketcheck.arn}"
      bucket_exceptions = "${join(",", var.bucket_exceptions)}"
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_s3bucketcheck" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.lambda_s3bucketcheck.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.s3bucketcheck_schedule.arn}"
}
