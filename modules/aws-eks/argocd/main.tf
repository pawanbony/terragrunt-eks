resource "helm_release" "argocd" {
  name      = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart     = "argo-cd"
  version   = "5.45.0"
  namespace = "argocd" 
  create_namespace = true

  set {
    name  = "configs.params.server\\.insecure"
    value = true
  }

  set {
    name  = "configs.params.server\\.rootpath"
    value = "/argocd"
  }

  set {
    name  = "server.ingress.enabled"
    value = true
  }

  set {
    name  = "server.ingress.hosts[0]"
    value = var.ingress_host
  }

}

