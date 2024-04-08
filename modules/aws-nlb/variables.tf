variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "internal" {
  type = bool
}

variable "static_subnet_mappings" {
  type = list(object({
    subnet_id  = string,
    ip_address = string
  }))
}

variable "lb_listeners" {
  type = list(object({
    target_group_name_prefix       = string
    target_group_port              = number
    target_group_health_check_port = number
    listener_port                  = number
    protocol                       = string
  }))
}

variable "tags" {
  type    = map(any)
  default = {}
}
variable "create_security_group" {
  description = "Determines if a security group is created"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name to use on security group created"
  type        = string
  default     = null
}

variable "security_group_use_name_prefix" {
  description = "Determines whether the security group name (`security_group_name`) is used as a prefix"
  type        = bool
  default     = false
}

variable "security_group_description" {
  description = "Description of the security group created"
  type        = string
  default     = null
}

variable "security_group_ingress_rules" {
  description = "Security group ingress rules to add to the security group created"
  type        = any
  default     = {}
}

variable "security_group_egress_rules" {
  description = "Security group egress rules to add to the security group created"
  type        = any
  default     = {}
}

variable "security_group_tags" {
  description = "A map of additional tags to add to the security group created"
  type        = map(string)
  default     = {}
}
variable "load_balancer_type" {
  description = "The type of loadbalancer that the security group is being attached to"
  type        = string
  default     = "network"
}
