# InnovateMart Project Setup Guide

## Infrastructure Created:
- VPC with public/private subnets
- EKS Kubernetes cluster
- IAM user for developers with read-only access

## Access Information:

### Admin Access:
```bash
aws eks update-kubeconfig --region eu-west-2 --name innovatemart-eks
kubectl get nodes
