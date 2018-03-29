# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# These variables must be passed in by the operator.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "The name of the ECS Service."
}

variable "ecs_cluster_id" {
  description = "The ID of the ECS Cluster this ECS Service should run in."
}

variable "app_images" {
  description = "The Docker image to run in the ECS Task (e.g. foo/bar)."
  type        = "list"
  # default     = ["elasticsearch:6.2.2"]
}

variable "repositories" {
  type = "list"
  # default = ["elasticsearch"]
}

variable "app_ports" {
  type = "list"
}

variable "app_memory_repositories" {
  type = "list"
}

variable "container_port" {
  description = "The port the Docker container in the ECS Task is listening on."
}

variable "desired_count" {
  description = "The number of ECS Tasks to run for this ECS Service."
}

variable "elb_name" {
  description = "The name of the ELB with which this ECS Service should register."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# These variables have defaults, but may be overridden by the operator.
# ---------------------------------------------------------------------------------------------------------------------

variable "deployment_maximum_percent" {
  description = "The upper limit, as a percentage of var.desired_count, of the number of running ECS Tasks that can be running in a service during a deployment. Setting this to more than 100 means that during deployment, ECS will deploy new instances of a Task before undeploying the old ones."
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "The lower limit, as a percentage of var.desired_count, of the number of running ECS Tasks that must remain running and healthy in a service during a deployment. Setting this to less than 100 means that during deployment, ECS may undeploy old instances of a Task before deploying new ones."
  default     = 100
}
