locals {
  # Automatically load environment-level variables
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  region = local.region_vars.locals.aws_region
  env    = local.environment_vars.locals.environment

  tags = {
    "Managed-by" : "terraform",
    "Environment" : local.env
  }
}

dependency "eks-cluster" {
  config_path                             = "../cluster-main"
  mock_outputs_allowed_terraform_commands = ["validate"]
}

dependency "qa-policy" {
  config_path                             = "../qa-secrets-access-policy"
  mock_outputs_allowed_terraform_commands = ["validate"]
}

dependency "dev-policy" {
  config_path                             = "../dev-secrets-access-policy"
  mock_outputs_allowed_terraform_commands = ["validate"]
}
# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "tfr:///terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks?version=5.11.2"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  role_name                     = "${dependency.eks-cluster.outputs.eks_cluster_name}-external-secrets-auth"
  attach_external_secrets_policy = true
  oidc_providers = {
    one = {
      provider_arn               = dependency.eks-cluster.outputs.eks_oidc_provider_arn
      namespace_service_accounts = ["external-secrets:external-secrets-auth"]  #namespace:service_account
    }
  }
  role_policy_arns = {
    policy = dependency.qa-policy.outputs.arn
    policy2 = dependency.dev-policy.outputs.arn
  }
}
