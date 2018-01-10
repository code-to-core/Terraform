#!/bin/bash


#pip install awscli --upgrade --user
aws --version

aws ec2 describe-regions --output table
aws ec2 describe-key-pairs
aws ec2 describe-security-groups
aws ec2 describe-instances
