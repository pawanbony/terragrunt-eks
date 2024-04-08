locals {
  # Automatically load environment-level variables
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  region = local.region_vars.locals.aws_region
  env    = local.environment_vars.locals.environment

  tags = {
    "Managed-by" : "terraform",
    "Environment" : local.env,
    "map-migrated": "migIBPXQBYBLZ"
  }
}

dependency "stg-policy" {
  config_path                             = "../external-secrets-role-policy"
  mock_outputs_allowed_terraform_commands = ["validate"]
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "tfr:///terraform-aws-modules/iam/aws//modules/iam-assumable-role?version=5.30.0"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  create_role = true
  role_name = "external-secrets-assumable-role"
  description = "Policy for dev external secrets to access stg blue secrets manager"
  custom_role_policy_arns = [ dependency.stg-policy.outputs.arn ]
  number_of_custom_role_policy_arns = 1
  trusted_role_arns = [
    "role arn of ext-role created",
  ]
  role_requires_mfa = false
  tags =  local.tags
}
