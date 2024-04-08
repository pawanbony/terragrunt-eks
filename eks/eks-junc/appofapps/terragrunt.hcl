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
  config_path                             = "../cluster-main"
  mock_outputs_allowed_terraform_commands = ["validate"]
}
include {
  path = find_in_parent_folders()
}

terraform {
  source = "appofapps"
}

inputs = {
  eks_cluster_endpoint   = dependency.eks-cluster.outputs.cluster_endpoint
  eks_cluster_ca = dependency.eks-cluster.outputs.cluster_certificate_authority_data
  eks_cluster_name = dependency.eks-cluster.outputs.eks_cluster_name

}