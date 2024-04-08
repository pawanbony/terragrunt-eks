resource "aws_lb" "main" {
  name                             = var.name
  load_balancer_type               = "network"
  internal                         = var.internal
  enable_cross_zone_load_balancing = true
  security_groups = var.create_security_group ? [aws_security_group.this[0].id] : null

  dynamic "subnet_mapping" {
    for_each = {
      for m in var.static_subnet_mappings : m.subnet_id => m.ip_address
    }
    content {
      subnet_id            = subnet_mapping.key
      private_ipv4_address = subnet_mapping.value
    }
  }

  tags = var.tags
}

resource "aws_lb_target_group" "main" {
  count    = length(var.lb_listeners)
  name     = substr("${var.lb_listeners[count.index].target_group_name_prefix}-${var.name}", 0, 32)
  port     = var.lb_listeners[count.index].target_group_port
  protocol = "TCP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    protocol = var.lb_listeners[count.index].protocol
    port     = var.lb_listeners[count.index].target_group_health_check_port
  }
}

resource "aws_lb_listener" "main" {
  count             = length(var.lb_listeners)
  load_balancer_arn = aws_lb.main.arn
  port              = var.lb_listeners[count.index].listener_port
  protocol          = var.lb_listeners[count.index].protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main[count.index].arn
  }
}
