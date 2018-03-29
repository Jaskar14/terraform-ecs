#!/bin/sh
## terraform-provision.sh: script to handle provisioning of aws ecs instances via terraform

terraform plan -var-file="app.tfvars"