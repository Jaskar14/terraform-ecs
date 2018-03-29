#!/bin/sh
## terraform-destroy.sh: script to handle destroying aws ecs instances created by terraform

terraform destroy -var-file="app.tfvars"