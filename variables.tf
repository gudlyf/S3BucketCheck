# Email target will need to confirm subscription in order for SNS topics
# to be delivered.
variable "email_target" {
  type = "string"
  default = ""
}

# You may have buckets that are known to need public access and can be
# ignored.
variable "bucket_exceptions" {
  type = "list"
  default = ["null"]
}
