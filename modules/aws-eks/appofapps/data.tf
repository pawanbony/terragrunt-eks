locals {
  region = var.region == "" ? "us-west-2" : var.region
}

data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
}