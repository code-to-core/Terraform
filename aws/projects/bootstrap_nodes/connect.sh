#!/bin/sh


# Utility script to use the prodiced dns name and then SSH into the built
# AWS instance
addr=$(cat dns.txt)
ssh -v -i ~/.aws/aws.pem ubuntu@$addr
