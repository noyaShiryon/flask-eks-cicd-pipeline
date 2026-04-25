output "eks_cluster_name" {
  description = "Name of EKS cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.app.repository_url
}

output "iam_role_arn" {
  description = "I am role"
  value       = module.eks.cluster_iam_role_arn
}