# Deploy all Kubernetes manifests from the manifests folder
resource "kubectl_manifest" "application" {
  for_each = fileset(path.module, "manifests/*.yaml")
  
  yaml_body = file(each.value)
  
  depends_on = [
    kubernetes_namespace.retail_store,
    kubernetes_config_map.aws_auth
  ]
}
