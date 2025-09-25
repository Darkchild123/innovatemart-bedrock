# Kubernetes namespace for the retail store application
resource "kubernetes_namespace" "retail_store" {
  metadata {
    name = "retail-store"
  }

  depends_on = [module.eks]
}
