output "family" {
  value = aws_ecs_task_definition.mock.family
}

output "revision" {
  value = aws_ecs_task_definition.mock.revision
}

output "container_definitions_json" {
  value = local.container_definitions_json
}
