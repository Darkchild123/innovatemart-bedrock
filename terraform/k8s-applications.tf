# Application deployment will be enabled after infrastructure is ready
# resource "kubectl_manifest" "application" {
#   for_each = fileset(path.module, "manifests/*.yaml")
#   yaml_body = file(each.value)
#   depends_on = [kubernetes_namespace.retail_store]
# }
