#!/bin/sh
## es-deploy.sh: script to handle building es and then pushing up the task definition to the ecs repo

docker build -t elastic-search -f ./provision/docker/elasticsearch/Dockerfile .
docker build -t kibana -f ./provision/docker/kibana/Dockerfile .
ecs-cli compose --file ./provision/docker/docker-compose.yml --verbose up