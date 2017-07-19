resource "aws_iam_role" "iam_for_lambda_s3bucketcheck" {
  name = "iam_for_lambda_s3bucketcheck"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3bucketcheck_role_policy" {
  name = "s3bucketcheck_role_policy"
  role = "${aws_iam_role.iam_for_lambda_s3bucketcheck.name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3BucketCheckAccess",
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "SNS:Publish"
      ],
      "Resource": "${aws_sns_topic.sns_s3bucketcheck.arn}"
    }
  ]
}
EOF
}
