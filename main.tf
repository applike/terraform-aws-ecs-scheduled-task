module "default_label" {
  source      = "applike/label/aws"
  version     = "1.0.1"
  enabled     = var.enabled
  attributes  = var.attributes
  delimiter   = var.delimiter
  application = var.application
  project     = var.project
  family      = var.family
  environment = var.environment
  tags        = var.tags
}

module "task_label" {
  source     = "applike/label/aws"
  version    = "1.0.1"
  enabled    = var.enabled && length(var.task_role_arn) == 0
  context    = module.default_label.context
  attributes = compact(concat(var.attributes, ["task"]))
}

module "service_label" {
  source     = "applike/label/aws"
  version    = "1.0.1"
  enabled    = var.enabled
  context    = module.default_label.context
  attributes = compact(concat(var.attributes, ["service"]))
}

module "exec_label" {
  source     = "applike/label/aws"
  version    = "1.0.1"
  enabled    = var.enabled && length(var.task_exec_role_arn) == 0
  context    = module.default_label.context
  attributes = compact(concat(var.attributes, ["exec"]))
}

resource "aws_ecs_task_definition" "default" {
  count                    = var.enabled ? 1 : 0
  family                   = module.default_label.id
  container_definitions    = var.container_definition_json
  requires_compatibilities = [var.launch_type]
  network_mode             = var.network_mode
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = length(var.task_exec_role_arn) > 0 ? var.task_exec_role_arn : join("", aws_iam_role.ecs_exec.*.arn)
  task_role_arn            = length(var.task_role_arn) > 0 ? var.task_role_arn : join("", aws_iam_role.ecs_task.*.arn)

  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration == null ? [] : [var.proxy_configuration]
    content {
      type           = lookup(proxy_configuration.value, "type", "APPMESH")
      container_name = proxy_configuration.value.container_name
      properties     = proxy_configuration.value.properties
    }
  }

  dynamic "placement_constraints" {
    for_each = var.task_placement_constraints
    content {
      type       = placement_constraints.value.type
      expression = lookup(placement_constraints.value, "expression", null)
    }
  }

  dynamic "volume" {
    for_each = var.volumes
    content {
      host_path = lookup(volume.value, "host_path", null)
      name      = volume.value.name

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
          scope         = lookup(docker_volume_configuration.value, "scope", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = lookup(volume.value, "efs_volume_configuration", [])
        content {
          file_system_id          = lookup(efs_volume_configuration.value, "file_system_id", null)
          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", null)
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", null)
          dynamic "authorization_config" {
            for_each = lookup(volume.value, "authorization_config", [])
            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }

  tags = var.use_old_arn ? null : module.default_label.tags
}

# IAM
data "aws_iam_policy_document" "ecs_task" {
  count = var.enabled && length(var.task_role_arn) == 0 ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task" {
  count = var.enabled && length(var.task_role_arn) == 0 ? 1 : 0

  name                 = module.task_label.id
  assume_role_policy   = join("", data.aws_iam_policy_document.ecs_task.*.json)
  permissions_boundary = var.permissions_boundary == "" ? null : var.permissions_boundary
  tags                 = module.task_label.tags
}

data "aws_iam_policy_document" "ecs_service" {
  count = var.enabled ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_service" {
  count                = var.enabled && var.network_mode != "awsvpc" && length(var.task_role_arn) == 0 && length(var.task_exec_role_arn) == 0 ? 1 : 0
  name                 = module.service_label.id
  assume_role_policy   = join("", data.aws_iam_policy_document.ecs_service.*.json)
  permissions_boundary = var.permissions_boundary == "" ? null : var.permissions_boundary
  tags                 = module.service_label.tags
}

data "aws_iam_policy_document" "ecs_service_policy" {
  count = var.enabled && var.network_mode != "awsvpc" ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "ec2:Describe*",
      "ec2:AuthorizeSecurityGroupIngress",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_service" {
  count  = var.enabled && length(var.task_role_arn) == 0 && length(var.task_exec_role_arn) == 0 && var.network_mode != "awsvpc" ? 1 : 0
  name   = module.service_label.id
  policy = join("", data.aws_iam_policy_document.ecs_service_policy.*.json)
  role   = join("", aws_iam_role.ecs_service.*.id)
}

# IAM role that the Amazon ECS container agent and the Docker daemon can assume
data "aws_iam_policy_document" "ecs_task_exec" {
  count = var.enabled && length(var.task_exec_role_arn) == 0 ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_exec" {
  count                = var.enabled && length(var.task_exec_role_arn) == 0 ? 1 : 0
  name                 = module.exec_label.id
  assume_role_policy   = join("", data.aws_iam_policy_document.ecs_task_exec.*.json)
  permissions_boundary = var.permissions_boundary == "" ? null : var.permissions_boundary
  tags                 = module.exec_label.tags
}

data "aws_iam_policy_document" "ecs_exec" {
  count = var.enabled && length(var.task_exec_role_arn) == 0 ? 1 : 0

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ssm:GetParameters",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_exec" {
  count  = var.enabled && length(var.task_exec_role_arn) == 0 ? 1 : 0
  name   = module.exec_label.id
  policy = join("", data.aws_iam_policy_document.ecs_exec.*.json)
  role   = join("", aws_iam_role.ecs_exec.*.id)
}

resource "aws_cloudwatch_event_rule" "default" {
  count  = var.enabled && length(var.schedule_expression) > 0 ? 1 : 0
  name                = module.default_label.id
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "default" {
  count  = var.enabled && length(var.schedule_expression) > 0 ? 1 : 0
  arn       = var.ecs_cluster_arn
  rule      = aws_cloudwatch_event_rule.default.*.name
  target_id = aws_cloudwatch_event_rule.default.*.name
  role_arn  = null

  ecs_target {
    task_definition_arn = aws_ecs_task_definition.default.*.arn
  }
}