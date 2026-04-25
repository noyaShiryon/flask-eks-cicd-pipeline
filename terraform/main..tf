# Create the VPC for the EKS cluster
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true # Cost optimization for non-prod environments

  # Required tags for Kubernetes cloud provider to identify subnets
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Create ECR repository for our application images
resource "aws_ecr_repository" "app" {
  name                 = "flask-app-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true # Security best practice: scans for vulnerabilities
  }
}

# Provision EKS cluster using official module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true # Accessible for GitHub Actions and local kubectl

  # Define managed node groups for worker instances
  eks_managed_node_groups = {
    group_1 = {
      min_size     = 1
      max_size     = 2
      desired_size = 1
      instance_types = ["t3.medium"] # Balanced performance and cost
    }
  }
}