output "target_groups_with_listeners" {
  value = { for i in var.lb_listeners :
    aws_lb_target_group.main[index(var.lb_listeners, i)].name => {
      target_group_arn  = aws_lb_target_group.main[index(var.lb_listeners, i)].arn
      listener_port     = i.listener_port
      target_group_port = i.target_group_port
    }
  }
}

output "ip_addresses" {
  value = [for subnet in var.static_subnet_mappings : subnet.ip_address]
}

output "name" {
  value = var.name
}
output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = try(aws_security_group.this[0].arn, null)
}

output "security_group_id" {
  description = "ID of the security group"
  value       = try(aws_security_group.this[0].id, null)
}

