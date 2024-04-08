data "kubectl_file_documents" "application" {
    content = file("manifest.yaml")
} 


resource "kubectl_manifest" "namespace" {
    count     = length(data.kubectl_file_documents.application.documents)
    yaml_body = element(data.kubectl_file_documents.application.documents, count.index)
    override_namespace = "argocd"
}