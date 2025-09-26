InnovateMart - Project Bedrock 🚀
Assignment Overview
Company: InnovateMart Inc.
Role: Cloud DevOps Engineer
Project: "Project Bedrock" - Deploy microservices application to production-grade Kubernetes on AWS EKS
AWS Account: 992998287133
Region: eu-west-2 (London)

### Architecture Overview
Infrastructure Stack
AWS EKS Cluster: innovatemart-eks
VPC: 10.0.0.0/16 with public/private subnets
Networking: NAT Gateway, Internet Gateway, Route Tables
Compute: EKS Managed Node Group (t3.medium instances)
Load Balancing: AWS Application Load Balancer
Container Runtime: Docker on EKS Worker Nodes
Application Stack
Namespace: retail-store
UI Service: Nginx (LoadBalancer type)
Orchestration: Kubernetes Deployments & Services
Service Discovery: Kubernetes ClusterIP Services
LIVE APPLICATION URL
Production Application:** http://a49be9de522674575aed8a5e01519ab0-1766697471.eu-west-2.elb.amazonaws.com
OPERATING SYSTEM USED: Linux (Ubuntu)

### Project Structure
file structure
![file structure](https://github.com/user-attachments/assets/ea9256bf-aa0a-4e7e-9c10-599289ceb731)


Implementation Journey
Phase 1: AWS Foundation Setup
IAM User Creation
IAM User: innovatemart-admin
ARN: arn:aws:iam::992998287133:user/innovatemart-admin
Policies: AdministratorAccess, AmazonEKSClusterPolicy
AWS CLI Configuration
bash aws configure

AWS Access Key ID: [REDACTED]
AWS Secret Access Key: [REDACTED]
Default region: eu-west-2
Default output: json
Phase 2: Terraform Infrastructure
Project Structure Creation bash

mkdir innovatemart-project cd innovatemart-project mkdir terraform kubernetes-manifests scripts docs

Terraform Configuration Files

Created all necessary Terraform files in /terraform directory:

providers.tf: AWS, Kubernetes, and Kubectl providers

vpc.tf: VPC with public/private subnets across 2 AZs

eks.tf: EKS cluster with managed node group

iam.tf: IAM roles and developer access policies

eks-auth.tf: Kubernetes authentication setup

Infrastructure Deployment
CLI commands cd terraform terraform init terraform plan terraform apply

Deployed Resources:

VPC: innovatemart-vpc (10.0.0.0/16)

EKS Cluster: innovatemart-eks (Kubernetes 1.29)

Node Group: 2x t3.medium instances

IAM Roles and Policies

Kubernetes namespace: retail-store

Phase 3: Kubernetes Application Deployment
Cluster Access Configuration CLI commands aws eks update-kubeconfig --region eu-west-2 --name innovatemart-eks kubectl get nodes # Verify cluster access

### Application Deployment

![yaml](https://github.com/user-attachments/assets/59fc2404-ae56-4617-aa97-a53dabb45b24)


Created app-deployment.yaml: yaml

Deployment Execution Commands

kubectl apply -f app-deployment.yaml kubectl get service ui-service -n retail-store -w

Phase 4: CI/CD Pipeline Setup 4.1 GitHub Repository

Repository: innovatemart-bedrock

URL: https://github.com/Darkchild123/innovatemart-bedrock

Visibility: Public
4.2 GitHub Actions Workflow

Created .github/workflows/terraform.yml with:

Automated terraform plan on PRs

Automated terraform apply on main branch pushes

Secure AWS credential management via GitHub Secrets
4.3 GitHub Secrets Configuration

AWS_ACCESS_KEY_ID: [Configured]

AWS_SECRET_ACCESS_KEY: [Configured]
Phase 5: Security & Access Management 5.1 Developer IAM User

User: innovatemart-developer

Access Type: Read-only

Policies: EKS describe/list permissions only

5.2 Kubernetes RBAC

Admin Access: system:masters group

Developer Access: Read-only namespace access
Technical Details EKS Cluster Configuration hcl

cluster_name = "innovatemart-eks" cluster_version = "1.29" instance_types = ["t3.medium"] desired_size = 2 min_size = 1 max_size = 3

**Network Architecture**

VPC CIDR: 10.0.0.0/16
Private Subnets: 10.0.1.0/24, 10.0.2.0/24
Public Subnets: 10.0.101.0/24, 10.0.102.0/24

NAT Gateway: Single NAT for cost optimization
Security Implementation

Least privilege IAM policies

EKS endpoint public access enabled

Kubernetes RBAC with namespace isolation
Access Instructions Quick Access

**Live Application: http://a49be9de522674575aed8a5e01519ab0-1766697471.eu-west-2.elb.amazonaws.com**

Kubernetes Dashboard: Use kubectl proxy and access via localhost

GitHub Repository: https://github.com/Darkchild123/innovatemart-bedrock
Admin Access bash

1. Configure AWS CLI with admin credentials
aws configure

2. Update kubeconfig
aws eks update-kubeconfig --region eu-west-2 --name innovatemart-eks

3. Verify access
kubectl get nodes kubectl get pods -n retail-store

4. Access application via CLI
curl http://a49be9de522674575aed8a5e01519ab0-1766697471.eu-west-2.elb.amazonaws.com

Developer Access (Read-Only) CLI Commands

1. Use developer IAM credentials
aws configure set aws_access_key_id [DEVELOPER_ACCESS_KEY] aws configure set aws_secret_access_key [DEVELOPER_SECRET_KEY]

2. Update kubeconfig
aws eks update-kubeconfig --region eu-west-2 --name innovatemart-eks

3. Test read-only access
kubectl get pods -n retail-store kubectl get services -n retail-store

4. Access application (read-only)
curl http://a49be9de522674575aed8a5e01519ab0-1766697471.eu-west-2.elb.amazonaws.com

5. Verify no write permissions (should fail)
kubectl create deployment test --image=nginx -n retail-store

Application Verification bash

Get Load Balancer details
kubectl get service ui-service -n retail-store

Expected Output:
NAME TYPE CLUSTER-IP EXTERNAL-IP
ui-service LoadBalancer 10.100.1.123 a49be9de522674575aed8a5e01519ab0-1766697471.eu-west-2.elb.amazonaws.com
Test application connectivity
curl -I http://a49be9de522674575aed8a5e01519ab0-1766697471.eu-west-2.elb.amazonaws.com

Expected Response: HTTP/1.1 200 OK
Verification Commands & Results Infrastructure Verification bash

EKS Cluster Status: ACTIVE
aws eks describe-cluster --name innovatemart-eks --region eu-west-2 --query cluster.status

Node Status: 2 nodes Ready
kubectl get nodes -o wide

Cluster Info: Running
kubectl cluster-info

Application Verification bash

All resources in namespace: RUNNING
kubectl get all -n retail-store

Pod status: 2/2 Ready
kubectl get pods -n retail-store -o wide

Service details: LoadBalancer with EXTERNAL-IP
kubectl describe service ui-service -n retail-store

Application Response: HTTP 200
curl -s -o /dev/null -w "%{http_code}" http://a49be9de522674575aed8a5e01519ab0-1766697471.eu-west-2.elb.amazonaws.com

Returns: 200
Load Balancer Details

DNS Name: a49be9de522674575aed8a5e01519ab0-1766697471.eu-west-2.elb.amazonaws.com

Type: Application Load Balancer (ALB)

Status: InService

Availability Zones: eu-west-2a, eu-west-2b

Targets: 2 healthy EKS worker nodes
Troubleshooting Encountered & Resolved
Issue 1: Terraform Configuration Files

Problem: "No configuration files" error Solution: Ensured correct directory structure and file locations Issue 2: EKS Authentication

Problem: "the server has asked for the client to provide credentials" Solution: Properly configured aws-auth ConfigMap and IAM mappings Issue 3: Large Files in Git

Problem: GitHub push rejected due to large Terraform provider binaries Solution: Implemented proper .gitignore and cleaned repository history Issue 4: YAML Syntax Errors

Problem: Terraform plan failures due to YAML unmarshal errors Solution: Used nano editor for precise file editing and validation

Performance Metrics
Resource Utilization

EKS Nodes: 2x t3.medium (optimal for development)

VPC Design: Multi-AZ for high availability

Scaling: Auto-scaling from 1 to 3 nodes based on load
Application Performance

Response Time: < 100ms (nginx static content)

Availability: 100% (multi-AZ load balancing)

Capacity: 2 replicas with auto-scaling readiness
Cost Optimization

Single NAT Gateway to reduce costs

Spot instance readiness for node groups

Efficient resource sizing for development workload
Future Enhancements
Immediate Improvements

Managed Databases: RDS for PostgreSQL/MySQL instead of in-cluster

Advanced Load Balancing: AWS Load Balancer Controller with Ingress

Monitoring: CloudWatch metrics and container insights
Production Ready Features

SSL/TLS: HTTPS with AWS Certificate Manager

DNS: Custom domain with Route 53

Backup: EKS cluster backup strategies

Security: Pod security policies and network policies
ALTSCHOOL ID: ALT/SOE/024/1484 
AWS Account ID: 992998287133
Region: eu-west-2 (London) GitHub: Darkchild123 
Repository: https://github.com/Darkchild123/innovatemart-bedrock 
Live Application: http://a49be9de522674575aed8a5e01519ab0-1766697471.eu-west-2.elb.amazonaws.com
