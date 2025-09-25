# Output important information
output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

output "developer_access_key" {
  description = "Developer IAM Access Key ID"
  value       = aws_iam_access_key.developer.id
  sensitive   = true
}

output "developer_secret_key" {
  description = "Developer IAM Secret Access Key"
  value       = aws_iam_access_key.developer.secret
  sensitive   = true
}

output "developer_kubeconfig_instructions" {
  description = "Instructions for developer access"
  value = <<EOT

=== DEVELOPER ACCESS INSTRUCTIONS ===

1. Configure AWS CLI:
aws configure set aws_access_key_id ${aws_iam_access_key.developer.id}
aws configure set aws_secret_access_key ${aws_iam_access_key.developer.secret}
aws configure set region eu-west-2

2. Update kubeconfig:
aws eks update-kubeconfig --region eu-west-2 --name ${module.eks.cluster_name}

3. Test access (read-only):
kubectl get pods -n retail-store
kubectl get services -n retail-store

4. Developer can only view resources, not modify them.

EOT
}

output "application_url" {
  description = "URL to access the application"
  value       = "Wait for UI service external IP, then check: kubectl get service ui-service -n retail-store"
}
