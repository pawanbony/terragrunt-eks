

resource "kubernetes_secret" "eks-repo-secret" {
  metadata {
    name      = var.secret_name
    namespace = var.namespace

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    url = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.appofapps_current.secret_string))["repo_url"]
    username = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.appofapps_current.secret_string))["username"]
    password = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.appofapps_current.secret_string))["password"]
    type = "git"
  }
}

