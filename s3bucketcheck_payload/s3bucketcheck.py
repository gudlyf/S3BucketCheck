from __future__ import print_function
import os
import boto3
import json

print('Loading function')

def lambda_handler(event, context):
    message = ""

    s3 = boto3.resource('s3')
    
    for bucket in (s3.buckets.all()):
        bucket_acl = bucket.Acl()
        for grant in bucket_acl.grants:
            if bucket.name not in os.environ['bucket_exceptions'].split(','):
                if "Group" in grant['Grantee']['Type'] and "AllUsers" in grant['Grantee']['URI']:
                    message += '{"' + bucket.name + '": "AllUsers ' + grant['Permission'] + '"},'
                if "Group" in grant['Grantee']['Type'] and "AuthenticatedUsers" in grant['Grantee']['URI']:
                    message += '{"' + bucket.name + '": "AuthenticatedUsers ' + grant['Permission'] + '"},'

    if message:
        print(message)
        sns_client = boto3.client('sns')
        response = sns_client.publish(
                TargetArn=os.environ['sns_arn'],
                Message=json.dumps({'default': json.dumps(message)}),
                Subject='S3BucketCheck Report'
            )
