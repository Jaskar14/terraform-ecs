Provisioning Elasticsearch
===========

# Getting Started
* Each directory 2.2.1 and 5.3.0 correspond to various Elasticsearch versions
* We started the project with 2.2.1 and eventually moved to 5.3.0.
* Each Elasticsearch cluster is provisioned a bit differently and each
uses a different version of ansible
* We’re using virtualenv to manage the differing ansible dependencies
* 2.2.1 should use ansible version 1.9 and 5.3.0 should use the latest ansible version
* In each directory you can get started by:
```
# If virtualenv is not installed
sudo pip install virtualenv

# If just setting up the project run
virtualenv venv

# Start up the environment
. venv/bin/activate

# Upgrade PIP to the latest
pip install --upgrade pip

# Install requirements
pip install -r requirements.txt

# Restart the virtualenv shell
deactivate && . venv/bin/activate

# Check that you have the right ansible version
ansible --version
```

# Infrastructure
## Production
* Version: 5.4.0, [Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/5.4/index.html)
* 5 servers, each with 30.5GB of RAM (r3.xlarge), 1 and 4 had 20 GB of storage and 2 and 3 have 25 GB storage
5 has 20 GB of storage and is a [coordinating node](https://www.elastic.co/guide/en/kibana/current/production.html#load-balancing)
which is running kibana
* 5 Shards per node, with 2 replicas
* Heap Size: `15 gb`

## Staging
* Version 5.4.0
* 4 servers, each with 30.5GM of RAM (r3.xlarge), 3 with 20 GB of storage, and 1 with 30 GB of storage, and 1 with 25GB of storage
One node is a [coordinating node](https://www.elastic.co/guide/en/kibana/current/production.html#load-balancing)
node which runs kibana and essentially a load balancer instance of ES
* Heap Size: `15 gb`


# Additional Server Setup
* Initiate a new server in the ec2 console
* Add a new user called `vmg` and grant it sudo permissions. Add in the password
(get from Khaliq) and in necessary public keys
