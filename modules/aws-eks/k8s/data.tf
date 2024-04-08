### argo cd eks cluster ##
data "aws_eks_cluster" "argocd_eks_cluster" {
    count = local.argocd_add_cluster ? 1 : 0
    name = local.argocd_eks_cluster
    provider = aws.argocd
}

# module "test_oidc_role" {
#   source                        = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   version                       = "5.11.2"
#   role_name                     = "${local.eks_cluster_name}-tg-oidc-test"
#   role_policy_arns = {
#     policy = "arn:aws:iam::aws:policy/AdministratorAccess"
#   }
#   oidc_providers = {
#     one = {
#       provider_arn               = local.cluster_identity_oidc_issuer_arn
#       namespace_service_accounts = ["agentpools:terragrunt-agent"]  #namespace:service_account
#     }
#   }
# }