variable "vpc_id" {
  type        = string
  description = "The VPC ID where resources are created"
  default     = null
}

variable "ecs_cluster_arn" {
  type        = string
  description = "The ARN of the ECS cluster where service will be provisioned"
}

variable "container_definition_json" {
  type        = string
  description = <<-EOT
    A string containing a JSON-encoded array of container definitions
    (`"[{ "name": "container1", ... }, { "name": "container2", ... }]"`).
    See [API_ContainerDefinition](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html),
    [cloudposse/terraform-aws-ecs-container-definition](https://github.com/cloudposse/terraform-aws-ecs-container-definition), or
    [ecs_task_definition#container_definitions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#container_definitions)
    EOT
}

variable "security_group_enabled" {
  type        = bool
  description = "Whether to create default Security Group for ECS service."
  default     = false
}

variable "security_group_description" {
  type        = string
  default     = "ECS service Security Group"
  description = "The Security Group description."
}

variable "security_group_use_name_prefix" {
  type        = bool
  default     = false
  description = "Whether to create a default Security Group with unique name beginning with the normalized prefix."
}

variable "security_group_rules" {
  type = list(any)
  default = [
    {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    },
    {
      type        = "ingress"
      from_port   = 8
      to_port     = 0
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Enables ping command from anywhere, see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-rules-reference.html#sg-rules-ping"
    }
  ]
  description = <<-EOT
    A list of maps of Security Group rules.
    The values of map is fully complated with `aws_security_group_rule` resource.
    To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule .
  EOT
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
  default     = []
  description = <<-EOT
    A set of placement constraints rules that are taken into consideration during task placement.
    Maximum number of placement_constraints is 10. See [`placement_constraints`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#placement-constraints-arguments)
    EOT
}

variable "network_mode" {
  type        = string
  description = "The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` or `null` for `EC2` `launch_type`"
  default     = null
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

variable "task_exec_policy_arns" {
  type        = list(string)
  description = "A list of IAM Policy ARNs to attach to the generated task execution role."
  default     = []
}

variable "task_role_arn" {
  type        = string
  description = "The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services"
  default     = ""
}

variable "task_policy_arns" {
  type        = list(string)
  description = "A list of IAM Policy ARNs to attach to the generated task role."
  default     = []
}

variable "service_role_arn" {
  type        = string
  description = "ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here."
  default     = null
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

variable "task_definition" {
  type        = string
  description = "Reuse an existing task definition family and revision for the ecs service instead of creating one"
  default     = null
}

variable "exec_enabled" {
  type        = bool
  description = "Specifies whether to enable Amazon ECS Exec for the tasks within the service"
  default     = false
}

variable "ecs_service_role_enabled" {
  type        = bool
  description = "Specifies whether to enable Amazon ECS service role"
  default     = false
}

variable "schedule_expression" {
  type        = string
  default     = ""
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus."
}

variable "cloudwatch_event_role_arn" {
  type        = string
  default     = ""
  description = "The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered."
}

variable "is_enabled" {
  type        = bool
  description = "Whether the rule should be enabled."
  default     = true
}

variable "task_count" {
  type        = number
  description = "The number of tasks to create based on the TaskDefinition."
  default     = null
}