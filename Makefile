AWS_PROFILE = personal-aws-account
AWS_REGION := $(shell aws configure get region --profile $(AWS_PROFILE))
ELASTICSEARCH_REPO = 950172495016.dkr.ecr.us-east-1.amazonaws.com
KIBANA_REPO	= 950172495016.dkr.ecr.us-east-1.amazonaws.com

.PHONY: terraform-init
terraform-init :
	bin/terraform-init.sh

.PHONY: terraform-plan
terraform-plan :
	bin/terraform-provision.sh

.PHONY: terraform-apply
terraform-apply :
	bin/terraform-deploy.sh

.PHONY: terraform-destroy
terraform-destroy :
	bin/terraform-destroy.sh

.PHONY: deploy
deploy :
	docker build -t elastic-search -f ./provision/docker/elasticsearch/Dockerfile .
	docker tag elastic-search $(ELASTICSEARCH_REPO)/elasticsearch
	docker push $(ELASTICSEARCH_REPO)/elasticsearch
	docker build -t kibana -f ./provision/docker/kibana/Dockerfile .
	docker tag kibana $(KIBANA_REPO)/kibana
	docker push $(KIBANA_REPO)/kibana
	# ecs-cli compose --file ./provision/docker/docker-compose.yml --cluster terraform-ecs-cluster --region us-east-1 up --launch-type EC2 --verbose up
	ecs-cli compose --file ./provision/docker/docker-compose.yml --cluster terraform-ecs-cluster --region us-east-1 up --launch-type EC2 up

.PHONY: create-repositories
create-repositories:
	aws ecr create-repository --repository-name elasticsearch --profile $(AWS_PROFILE)
	aws ecr create-repository --repository-name kibana --profile $(AWS_PROFILE)

.PHONY: get-login
get-login:
	aws ecr get-login  --no-include-email  --region $(AWS_REGION) --profile $(AWS_PROFILE)