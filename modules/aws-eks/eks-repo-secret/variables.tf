variable "secret_name" {
  description = "name of the secret"
  type        = string
}

variable "namespace" {
  description = "name of the namespace"
  type        = string
}

variable "appofapps_aws_secret_name" {
  description = "Secret Name for appofapps"
  default = ""
}

variable "eks_cluster_name" {
  description = "eks cluster name"
}

variable "region" {
  description = "eks cluster region name"
  default = ""
}

# variable "repo_url" {
#   description = "name of the namespace"
#   type        = string
# }

# variable "username" {
#   description = "name of the namespace"
#   type        = string
# }

# variable "password" {
#   description = "name of the namespace"
#   type        = string
#}