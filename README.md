<<<<<<< HEAD
# innovatemart-bedrock
Project Bedrock - EKS deployment for InnovateMart retail store application
=======
# InnovateMart - Project Bedrock

## Project Overview
Infrastructure as Code for deploying retail store application to Amazon EKS.

## Architecture
- AWS EKS Cluster
- VPC with public/private subnets
- Microservices application
- CI/CD with GitHub Actions

## Quick Start
```bash
cd terraform
terraform init
terraform apply
>>>>>>> 7e4e8df (Initial commit: EKS infrastructure and application deployment)

## Architecture Overview
- **VPC**: 10.0.0.0/16 with public/private subnets
- **EKS Cluster**: Kubernetes 1.29 with 2 t3.medium nodes
- **Application**: Retail store microservices running in `retail-store` namespace
- **Database**: In-cluster MySQL, PostgreSQL, Redis, RabbitMQ, DynamoDB Local

## Access Instructions

### Admin Access:
```bash
aws eks update-kubeconfig --region eu-west-2 --name innovatemart-eks
kubectl get nodes
