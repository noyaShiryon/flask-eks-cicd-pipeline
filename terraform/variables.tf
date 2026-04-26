variable "aws_region" {
  description = "AWS region resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Enviroment name"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "Name of the EKS cluste"
  type        = string
  default     = "flask-cluster-v2"
}
