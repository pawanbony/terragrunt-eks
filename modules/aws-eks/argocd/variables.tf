variable "region" {
  description = "eks cluster region name"
  default = "us-west-2"
}

variable "eks_cluster_name" {
  description = "Name of the existing EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
}

variable "cluster_certificate_authority_data" {
}

variable "ingress_host" {
  type = string
}
