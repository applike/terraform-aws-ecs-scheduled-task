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
| terraform | >= 0.14.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| exec_label | applike/label/aws | 1.1.0 |
| service_label | applike/label/aws | 1.1.0 |
| task_label | applike/label/aws | 1.1.0 |
| this | applike/label/aws | 1.1.0 |

## Resources

| Name |
|------|
| [aws_cloudwatch_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) |
| [aws_cloudwatch_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) |
| [aws_ecs_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) |
| [aws_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tag\_map | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| application | Solution application, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| cloudwatch\_event\_role\_arn | The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. | `string` | `""` | no |
| container\_definition\_json | A string containing a JSON-encoded array of container definitions<br>(`"[{ "name": "container1", ... }, { "name": "container2", ... }]"`).<br>See [API\_ContainerDefinition](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html),<br>[cloudposse/terraform-aws-ecs-container-definition](https://github.com/cloudposse/terraform-aws-ecs-container-definition), or<br>[ecs\_task\_definition#container\_definitions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#container_definitions) | `string` | n/a | yes |
| context | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "application": null,<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "family": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "project": null,<br>  "regex_replace_chars": null,<br>  "tags": {}<br>}</pre> | no |
| delimiter | Delimiter to be used between `project`, `environment`, `family`, `application` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| ecs\_cluster\_arn | The ARN of the ECS cluster where service will be provisioned | `string` | n/a | yes |
| enable\_all\_egress\_rule | A flag to enable/disable adding the all ports egress rule to the ECS security group | `bool` | `false` | no |
| enable\_ecs\_service\_role | Specifies whether to enable Amazon ECS service role | `bool` | `false` | no |
| enable\_icmp\_rule | Specifies whether to enable ICMP on the security group | `bool` | `false` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| environment | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| exec\_enabled | Specifies whether to enable Amazon ECS Exec for the tasks within the service | `bool` | `false` | no |
| family | Family, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| id\_length\_limit | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| is\_enabled | Whether the rule should be enabled. | `bool` | `true` | no |
| label\_key\_case | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| label\_order | The naming order of the id output and Name tag.<br>Defaults to ["project", "environment", "family", "application", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| label\_value\_case | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| launch\_type | The launch type on which to run your service. Valid values are `EC2` and `FARGATE` | `string` | `"EC2"` | no |
| network\_mode | The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` or `null` for `EC2` `launch_type` | `string` | `null` | no |
| permissions\_boundary | A permissions boundary ARN to apply to the 3 roles that are created. | `string` | `""` | no |
| project | Project, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| proxy\_configuration | The proxy configuration details for the App Mesh proxy. See `proxy_configuration` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#proxy-configuration-arguments | <pre>object({<br>    type           = string<br>    container_name = string<br>    properties     = map(string)<br>  })</pre> | `null` | no |
| regex\_replace\_chars | Regex to replace chars with empty string in `project`, `environment`, `family` and `application`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| schedule\_expression | The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule\_expression or event\_pattern is required. Can only be used on the default event bus. | `string` | `""` | no |
| service\_role\_arn | ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here. | `string` | `null` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| task\_count | The number of tasks to create based on the TaskDefinition. | `number` | `null` | no |
| task\_cpu | The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `null` | no |
| task\_definition | Reuse an existing task definition family and revision for the ecs service instead of creating one | `string` | `null` | no |
| task\_exec\_policy\_arns | A list of IAM Policy ARNs to attach to the generated task execution role. | `list(string)` | `[]` | no |
| task\_exec\_role\_arn | The ARN of IAM role that allows the ECS/Fargate agent to make calls to the ECS API on your behalf | `string` | `""` | no |
| task\_memory | The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `null` | no |
| task\_placement\_constraints | A set of placement constraints rules that are taken into consideration during task placement.<br>Maximum number of placement\_constraints is 10. See [`placement_constraints`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#placement-constraints-arguments) | <pre>list(object({<br>    type       = string<br>    expression = string<br>  }))</pre> | `[]` | no |
| task\_policy\_arns | A list of IAM Policy ARNs to attach to the generated task role. | `list(string)` | `[]` | no |
| task\_role\_arn | The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services | `string` | `""` | no |
| use\_old\_arn | A flag to enable/disable tagging the ecs resources that require the new arn format | `bool` | `false` | no |
| volumes | Task volume definitions as list of configuration objects | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = string<br>      transit_encryption_port = string<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| vpc\_id | The VPC ID where resources are created | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| ecs\_exec\_role\_policy\_id | The ECS service role policy ID, in the form of `role_name:role_policy_name` |
| ecs\_exec\_role\_policy\_name | ECS service role name |
| service\_arn | ECS Service ARN |
| service\_name | ECS Service name |
| service\_role\_arn | ECS Service role ARN |
| service\_security\_group\_id | Security Group ID of the ECS task |
| task\_definition\_family | ECS task definition family |
| task\_definition\_revision | ECS task definition revision |
| task\_exec\_role\_arn | ECS Task exec role ARN |
| task\_exec\_role\_name | ECS Task role name |
| task\_role\_arn | ECS Task role ARN |
| task\_role\_id | ECS Task role id |
| task\_role\_name | ECS Task role name |

<!--- END_TF_DOCS --->