#!/bin/bash

(cd Terraform ; terraform destroy -force) | tee destroy.log
