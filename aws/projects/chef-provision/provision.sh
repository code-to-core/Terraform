#!/bin/bash

terraform apply -auto-approve | tee provision.log
