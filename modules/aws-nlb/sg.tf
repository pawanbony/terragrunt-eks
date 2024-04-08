locals {
  create_security_group = var.create_security_group
  security_group_name   = var.security_group_name
}

resource "aws_security_group" "this" {
  count = local.create_security_group ? 1 : 0

  name        = var.security_group_use_name_prefix ? null : local.security_group_name
  name_prefix = var.security_group_use_name_prefix ? "${local.security_group_name}-" : null
  description = coalesce(var.security_group_description, "Security group for ${local.security_group_name} ${var.load_balancer_type} load balancer")
  vpc_id      = var.vpc_id

  tags =  var.security_group_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = { for k, v in var.security_group_egress_rules : k => v if local.create_security_group }

  # Required
  security_group_id = aws_security_group.this[0].id
  ip_protocol       = try(each.value.ip_protocol, "tcp")

  # Optional
  cidr_ipv4                    = lookup(each.value, "cidr_ipv4", null)
  description                  = try(each.value.description, null)
  from_port                    = try(each.value.from_port, null)
  to_port                      = try(each.value.to_port, null)

  tags = var.security_group_tags
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = { for k, v in var.security_group_ingress_rules : k => v if local.create_security_group }

  # Required
  security_group_id = aws_security_group.this[0].id
  ip_protocol       = try(each.value.ip_protocol, "tcp")

  # Optional
  cidr_ipv4                    = lookup(each.value, "cidr_ipv4", null)
  description                  = try(each.value.description, null)
  from_port                    = try(each.value.from_port, null)
  to_port                      = try(each.value.to_port, null)

  tags = var.security_group_tags
}

