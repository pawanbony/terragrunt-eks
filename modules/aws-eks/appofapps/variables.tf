variable "eks_cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  type        = string
}

variable "eks_cluster_ca" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  type        = string
}

variable "eks_cluster_name" {
  description = "eks cluster name"
}

variable "region" {
  description = "eks cluster region name"
  default = ""
}