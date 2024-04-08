
locals {
  appofapps_aws_secret_name = var.appofapps_aws_secret_name == "" ? "appofapps-repo" : var.appofapps_aws_secret_name
  region = var.region == "" ? "us-west-2" : var.region
}

data "aws_secretsmanager_secret" "appofapps_secrets" {
  name = local.appofapps_aws_secret_name
}

data "aws_secretsmanager_secret_version" "appofapps_current" {
  secret_id = data.aws_secretsmanager_secret.appofapps_secrets.id
}


data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
}