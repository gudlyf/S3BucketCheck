# S3BucketCheck

Authored by: Keith McDuffee (gudlyf@realistek.com)

Date: 2017-07-19

Using terraform, creates a lambda function to check all of the account's
S3 bucket ACLs for any that are public read/write or authorized
global users read/write access. Sends output through SNS to email
target (currently only supporting one email address).

You must set AWS credentials for an account with permission to create
Lambda fuctions, CloudWatch events, IAM policies and roles, and
SNS topics within environment variables:

  AWS_REGION

  AWS_ACCESS_KEY_ID

  AWS_SECRET_ACCESS_KEY

  AWS_SECURITY_TOKEN (if using MFA)

  AWS_SESSION_TOKEN (if using MFA)

Then run 'make.sh'.
