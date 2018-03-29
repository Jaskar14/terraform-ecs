#!/bin/sh
## terraform-deploy.sh: script to handle deploying aws ecs instances via terraform

terraform apply -var-file="app.tfvars"