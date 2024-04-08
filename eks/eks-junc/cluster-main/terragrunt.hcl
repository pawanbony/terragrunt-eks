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

# Declare dependencies
dependency "vpc" {
  config_path = "${get_original_terragrunt_dir()}/../../network/vpc"
  mock_outputs_allowed_terraform_commands = ["validate"]
}

dependency "kms" {
  config_path = "${get_original_terragrunt_dir()}/../../kms/keys"
  mock_outputs_allowed_terraform_commands = ["validate"]
}


# # Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}


# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::cluster"
}

inputs = {
  cluster_name   = ""
  cluster_region = local.region
  environment = local.env
  kms_arn = dependency.kms.outputs.key_arns["${local.env}-eks-main"]
  vpc_id = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnets
  allow_https_cidr_blocks = [""]
  cluster_addons_versions = {
    coredns             = "v1.10.1-eksbuild.4"
    kube-proxy          = "v1.27.6-eksbuild.2"
    vpc-cni             = "v1.15.1-eksbuild.1"
    aws-ebs-csi-driver  = "v1.27.0-eksbuild.1"
    aws-efs-csi-driver  = "v1.7.4-eksbuild.1"
  }
  eks_managed_node_groups = {
        "regular" = {}
        "arm64" = {
            instance_types = ["m6g.large", "m6g.xlarge", "m7g.large", "m7g.xlarge", "t4g.large", "t4g.xlarge"]
            ami_type = "AL2_ARM_64"
        }
    }

  aws_auth_roles = [
        {
            rolearn  = ""
            username = "admin"
            groups   = ["system:masters"]
        },
        {
            rolearn  = ""
            username = "terragrunt_admin"
            groups   = ["system:masters"]
        }
  ]
}
