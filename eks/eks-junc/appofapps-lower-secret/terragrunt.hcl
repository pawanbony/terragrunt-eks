locals {
  # Automatically load environment-level variables
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Extract out common variables for reuse
  region = local.region_vars.locals.aws_region
  env    = local.environment_vars.locals.environment
  accountid = local.account_vars.locals.aws_account_id

  tags = {
    "Managed-by" : "terraform",
    "Environment" : local.env,
  }
}

dependency "eks-cluster" {
  config_path = "../cluster-main/"
  mock_outputs_allowed_terraform_commands = ["validate"]
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "eks-repo-secret"
}

inputs = {
  secret_name = ""
  namespace = "argocd"
  appofapps_aws_secret_name = ""
  eks_cluster_name = dependency.eks-cluster.outputs.eks_cluster_name
}