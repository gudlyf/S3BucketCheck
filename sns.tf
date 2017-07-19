resource "aws_sns_topic" "sns_s3bucketcheck" {
  name = "S3BucketCheck"
  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.email_target}"
  }
}
