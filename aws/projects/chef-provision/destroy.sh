#!/bin/bash

terraform destroy -force | tee destroy.log
