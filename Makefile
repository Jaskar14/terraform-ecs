AWS_PROFILE = personal-aws-account
AWS_REGION := $(shell aws configure get region --profile $(AWS_PROFILE))
ELASTICSEARCH_REPO = 950172495016.dkr.ecr.us-east-1.amazonaws.com
KIBANA_REPO	= 950172495016.dkr.ecr.us-east-1.amazonaws.com



# shell aws configure get region --profile personal-aws-account
# aws configure get cluster --profile personal-aws-account
# aws configure get keypair --profile personal-aws-account

.PHONY: terraform-init
terraform-init :
	bin/terraform-init.sh

.PHONY: terraform-provision
terraform-provision :
	bin/terraform-provision.sh

.PHONY: terraform-deploy
terraform-deploy :
	bin/terraform-deploy.sh

.PHONY: terraform-destroy
terraform-destroy :
	bin/terraform-destroy.sh

.PHONY: deploy
deploy :
	# bin/es-deploy.sh
	docker build -t elastic-search -f ./provision/docker/elasticsearch/Dockerfile .
	docker tag elastic-search $(ELASTICSEARCH_REPO)/elasticsearch
	docker push $(ELASTICSEARCH_REPO)/elasticsearch
	docker build -t kibana -f ./provision/docker/kibana/Dockerfile .
	docker tag kibana $(KIBANA_REPO)/kibana
	docker push $(KIBANA_REPO)/kibana
	ecs-cli compose --file ./provision/docker/docker-compose.yml --verbose up

.PHONY: create-repositories
create-repositories:
	aws ecr create-repository --repository-name elasticsearch --profile $(AWS_PROFILE)
	aws ecr create-repository --repository-name kibana --profile $(AWS_PROFILE)

.PHONY: get-login
get-login:
	$(aws ecr get-login  --no-include-email  --region $(AWS_REGION) --profile $(AWS_PROFILE))

.PHONE: test 
test:	
	echo ()

# .PHONY: configure
# configure:
# 	ecs-cli configure --cluster $(AWS_CLUSTER) --profile $(AWS_PROFILE)



# .PHONY: show-config
# show-config:
# 	@echo $(AWS_PROFILE)
# 	@echo $(AWS_REGION)
# 	@echo $(AWS_CLUSTER)
# 	@echo $(AWS_KEYPAIR)