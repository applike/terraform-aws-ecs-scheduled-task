variable "enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "project" {
  type        = string
  description = "Project (e.g. `eg` or `cp`)"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  default     = ""
}

variable "family" {
  type        = string
  description = "Family (e.g. `prod`, `dev`, `staging`)"
  default     = ""
}

variable "application" {
  type        = string
  description = "Name of the application"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  description = "Additional attributes (_e.g._ \"1\")"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags (_e.g._ { BusinessUnit : ABC })"
  default     = {}
}

variable "ecs_cluster_arn" {
  type        = string
  description = "The ARN of the ECS cluster where service will be provisioned"
}

variable "container_definition_json" {
  type        = string
  description = "A string containing a JSON-encoded array of container definitions (`\"[{ \"name\": \"container1\", ... }, { \"name\": \"container2\", ... }]\"`). See https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html, https://github.com/cloudposse/terraform-aws-ecs-container-definition, or https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#container_definitions"
}

variable "launch_type" {
  type        = string
  description = "The launch type on which to run your service. Valid values are `EC2` and `FARGATE`"
  default     = "EC2"
}

variable "task_placement_constraints" {
  type = list(object({
    type       = string
    expression = string
  }))
  description = "A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. See `placement_constraints` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#placement-constraints-arguments"
  default     = []
}

variable "network_mode" {
  type        = string
  description = "The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type`"
  default     = "bridge"
}

variable "task_cpu" {
  type        = number
  description = "The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = null
}

variable "task_memory" {
  type        = number
  description = "The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = null
}

variable "task_exec_role_arn" {
  type        = string
  description = "The ARN of IAM role that allows the ECS/Fargate agent to make calls to the ECS API on your behalf"
  default     = ""
}

variable "task_role_arn" {
  type        = string
  description = "The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services"
  default     = ""
}

variable "volumes" {
  type = list(object({
    host_path = string
    name      = string
    docker_volume_configuration = list(object({
      autoprovision = bool
      driver        = string
      driver_opts   = map(string)
      labels        = map(string)
      scope         = string
    }))
    efs_volume_configuration = list(object({
      file_system_id          = string
      root_directory          = string
      transit_encryption      = string
      transit_encryption_port = string
      authorization_config = list(object({
        access_point_id = string
        iam             = string
      }))
    }))
  }))
  description = "Task volume definitions as list of configuration objects"
  default     = []
}

variable "proxy_configuration" {
  type = object({
    type           = string
    container_name = string
    properties     = map(string)
  })
  description = "The proxy configuration details for the App Mesh proxy. See `proxy_configuration` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#proxy-configuration-arguments"
  default     = null
}

variable "permissions_boundary" {
  type        = string
  description = "A permissions boundary ARN to apply to the 3 roles that are created."
  default     = ""
}

variable "use_old_arn" {
  type        = bool
  description = "A flag to enable/disable tagging the ecs resources that require the new arn format"
  default     = false
}

variable "schedule_expression" {
  type = string
  default = null
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus."
}