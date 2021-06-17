# terraform-aws-ecs-scheduled-task

[![tflint](https://github.com/applike/terraform-aws-ecs-scheduled-task/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-aws-ecs-scheduled-task/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/applike/terraform-aws-ecs-scheduled-task/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-aws-ecs-scheduled-task/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![tfdoc](https://github.com/applike/terraform-aws-ecs-scheduled-task/workflows/tfdoc/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-aws-ecs-scheduled-task/actions?query=workflow%3Atfdoc+event%3Apush+branch%3Amaster)
[![release](https://github.com/applike/terraform-aws-ecs-scheduled-task/workflows/release/badge.svg?branch=master&event=push)](https://github.com/applike/terraform-aws-ecs-scheduled-task/actions?query=workflow%3Arelease+event%3Apush+branch%3Amaster)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/applike/terraform-aws-ecs-scheduled-task)
[![License](https://img.shields.io/github/license/applike/terraform-aws-ecs-scheduled-task)](https://github.com/applike/terraform-aws-ecs-scheduled-task/blob/master/LICENSE)

## Example
```hcl
module "example" {
  source  = "applike/ecs-scheduled-task/aws"
  version = "X.X.X"
}
```
<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_exec_label"></a> [exec\_label](#module\_exec\_label) | applike/label/aws | 1.1.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | cloudposse/security-group/aws | 0.3.1 |
| <a name="module_service_label"></a> [service\_label](#module\_service\_label) | applike/label/aws | 1.1.0 |
| <a name="module_task_label"></a> [task\_label](#module\_task\_label) | applike/label/aws | 1.1.0 |
| <a name="module_this"></a> [this](#module\_this) | applike/label/aws | 1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_ecs_task_definition.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ecs_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ecs_ssm_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ecs_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.ecs_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_service_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_ssm_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_task_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | Solution application, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_event_role_arn"></a> [cloudwatch\_event\_role\_arn](#input\_cloudwatch\_event\_role\_arn) | The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. | `string` | `""` | no |
| <a name="input_container_definition_json"></a> [container\_definition\_json](#input\_container\_definition\_json) | A string containing a JSON-encoded array of container definitions<br>(`"[{ "name": "container1", ... }, { "name": "container2", ... }]"`).<br>See [API\_ContainerDefinition](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html),<br>[cloudposse/terraform-aws-ecs-container-definition](https://github.com/cloudposse/terraform-aws-ecs-container-definition), or<br>[ecs\_task\_definition#container\_definitions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#container_definitions) | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "application": null,<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "family": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "project": null,<br>  "regex_replace_chars": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `project`, `environment`, `family`, `application` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | The ARN of the ECS cluster where service will be provisioned | `string` | n/a | yes |
| <a name="input_ecs_service_role_enabled"></a> [ecs\_service\_role\_enabled](#input\_ecs\_service\_role\_enabled) | Specifies whether to enable Amazon ECS service role | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_exec_enabled"></a> [exec\_enabled](#input\_exec\_enabled) | Specifies whether to enable Amazon ECS Exec for the tasks within the service | `bool` | `false` | no |
| <a name="input_family"></a> [family](#input\_family) | Family, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether the rule should be enabled. | `bool` | `true` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag.<br>Defaults to ["project", "environment", "family", "application", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | The launch type on which to run your service. Valid values are `EC2` and `FARGATE` | `string` | `"EC2"` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` or `null` for `EC2` `launch_type` | `string` | `null` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | A permissions boundary ARN to apply to the 3 roles that are created. | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | Project, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_proxy_configuration"></a> [proxy\_configuration](#input\_proxy\_configuration) | The proxy configuration details for the App Mesh proxy. See `proxy_configuration` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#proxy-configuration-arguments | <pre>object({<br>    type           = string<br>    container_name = string<br>    properties     = map(string)<br>  })</pre> | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `project`, `environment`, `family` and `application`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule\_expression or event\_pattern is required. Can only be used on the default event bus. | `string` | `""` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The Security Group description. | `string` | `"ECS service Security Group"` | no |
| <a name="input_security_group_enabled"></a> [security\_group\_enabled](#input\_security\_group\_enabled) | Whether to create default Security Group for ECS service. | `bool` | `false` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | A list of maps of Security Group rules.<br>The values of map is fully complated with `aws_security_group_rule` resource.<br>To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule . | `list(any)` | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow all outbound traffic",<br>    "from_port": 0,<br>    "protocol": -1,<br>    "to_port": 0,<br>    "type": "egress"<br>  },<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Enables ping command from anywhere, see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-rules-reference.html#sg-rules-ping",<br>    "from_port": 8,<br>    "protocol": "icmp",<br>    "to_port": 0,<br>    "type": "ingress"<br>  }<br>]</pre> | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Whether to create a default Security Group with unique name beginning with the normalized prefix. | `bool` | `false` | no |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_task_count"></a> [task\_count](#input\_task\_count) | The number of tasks to create based on the TaskDefinition. | `number` | `null` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `null` | no |
| <a name="input_task_definition"></a> [task\_definition](#input\_task\_definition) | Reuse an existing task definition family and revision for the ecs service instead of creating one | `string` | `null` | no |
| <a name="input_task_exec_policy_arns"></a> [task\_exec\_policy\_arns](#input\_task\_exec\_policy\_arns) | A list of IAM Policy ARNs to attach to the generated task execution role. | `list(string)` | `[]` | no |
| <a name="input_task_exec_role_arn"></a> [task\_exec\_role\_arn](#input\_task\_exec\_role\_arn) | The ARN of IAM role that allows the ECS/Fargate agent to make calls to the ECS API on your behalf | `string` | `""` | no |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `null` | no |
| <a name="input_task_placement_constraints"></a> [task\_placement\_constraints](#input\_task\_placement\_constraints) | A set of placement constraints rules that are taken into consideration during task placement.<br>Maximum number of placement\_constraints is 10. See [`placement_constraints`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#placement-constraints-arguments) | <pre>list(object({<br>    type       = string<br>    expression = string<br>  }))</pre> | `[]` | no |
| <a name="input_task_policy_arns"></a> [task\_policy\_arns](#input\_task\_policy\_arns) | A list of IAM Policy ARNs to attach to the generated task role. | `list(string)` | `[]` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services | `string` | `""` | no |
| <a name="input_use_old_arn"></a> [use\_old\_arn](#input\_use\_old\_arn) | A flag to enable/disable tagging the ecs resources that require the new arn format | `bool` | `false` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | Task volume definitions as list of configuration objects | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = string<br>      transit_encryption_port = string<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where resources are created | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_exec_role_policy_id"></a> [ecs\_exec\_role\_policy\_id](#output\_ecs\_exec\_role\_policy\_id) | The ECS service role policy ID, in the form of `role_name:role_policy_name` |
| <a name="output_ecs_exec_role_policy_name"></a> [ecs\_exec\_role\_policy\_name](#output\_ecs\_exec\_role\_policy\_name) | ECS service role name |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Security Group ARN of the ECS task |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security Group ID of the ECS task |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | Security Group name of the ECS task |
| <a name="output_service_role_arn"></a> [service\_role\_arn](#output\_service\_role\_arn) | ECS Service role ARN |
| <a name="output_task_definition_family"></a> [task\_definition\_family](#output\_task\_definition\_family) | ECS task definition family |
| <a name="output_task_definition_revision"></a> [task\_definition\_revision](#output\_task\_definition\_revision) | ECS task definition revision |
| <a name="output_task_exec_role_arn"></a> [task\_exec\_role\_arn](#output\_task\_exec\_role\_arn) | ECS Task exec role ARN |
| <a name="output_task_exec_role_name"></a> [task\_exec\_role\_name](#output\_task\_exec\_role\_name) | ECS Task role name |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | ECS Task role ARN |
| <a name="output_task_role_id"></a> [task\_role\_id](#output\_task\_role\_id) | ECS Task role id |
| <a name="output_task_role_name"></a> [task\_role\_name](#output\_task\_role\_name) | ECS Task role name |

<!--- END_TF_DOCS --->