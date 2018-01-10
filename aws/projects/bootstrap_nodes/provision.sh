#!/bin/bash

(cd Terraform && terraform apply -auto-approve) | tee provision.log
