
# AWS EKS Cloud Architecture & CI/CD Pipeline

A comprehensive DevOps project demonstrating a containerized Flask application deployed on a production-ready AWS EKS cluster. The project features Infrastructure as Code (IaC), automated CI/CD workflows, and Kubernetes orchestration.

## Project Overview
This repository implements a complete lifecycle of a web application:
- **Infrastructure:** Provisioned with **Terraform** (VPC, Subnets, EKS, ECR).
- **App:** Python **Flask** application with a Dockerized environment.
- **Orchestration:** **Kubernetes (EKS)** managed via **Helm Charts**.
- **Automation:** **GitHub Actions** for CI/CD (Infrastructure & Application).

## Architecture Components
- **Network:** Custom VPC with Public/Private subnets, NAT Gateway for secure egress.
- **Security:** IAM Roles for Service Accounts (IRSA), Security Groups for Node-to-Cluster communication.
- **State Management:** Terraform remote state stored in **S3** with **DynamoDB** state locking.

## Tech Stack
- **Cloud:** AWS (EKS, ECR, VPC, S3, DynamoDB)
- **IaC:** Terraform (HCL)
- **Containers:** Docker
- **Package Manager:** Helm 3
- **CI/CD:** GitHub Actions

## How to Deploy

### 1. Infrastructure Setup
Navigate to the terraform directory and initialize the backend:
```bash
cd terraform
terraform init
terraform apply -auto-approve


### 2. Configure Access
Update your local kubeconfig to interact with the new cluster:
```bash
aws eks update-kubeconfig --name flask-production-cluster --region us-east-1

### 3. CI/CD Pipeline
The pipeline is triggered automatically on every push to the main branch:
Build: Dockerizes the Flask app using a slim Python image.
Push: Tags and pushes the image to Amazon ECR with a unique Git SHA.
Deploy: Uses Helm to upgrade the application on the EKS cluster with zero downtime.

### Features & Best Practices
State Management: Terraform state is stored securely in an S3 bucket with DynamoDB locking.
Security: Implemented Least Privilege principle for IAM roles.
Scalability: EKS managed node groups for automated scaling.
Clean Code: Use of .gitignore to prevent sensitive data or heavy binaries from entering Git.

### Monitoring the Deployment
To check the status of your pods and get the LoadBalancer URL:
```bash
kubectl get pods
kubectl get svc flask-app
