#!/bin/bash

rm -f ./s3bucketcheck_payload.zip
zip -j ./s3bucketcheck_payload.zip s3bucketcheck_payload/s3bucketcheck.py

if [ -z $AWS_ACCESS_KEY_ID ]; then
	echo "  ** YOU MUST SETUP YOUR AWS CREDENTIALS FOR THE AWS ACCOUNT YOU ARE INSTALLING TO BEFORE RUNNING! **"
	exit 1
fi

terraform plan && terraform apply
