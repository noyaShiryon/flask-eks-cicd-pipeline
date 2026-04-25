variable "aws_region" {
    description = "AWS region resources"
    type=string
    default = "us-east-1"
}

variable "environment" {
    description = "Enviroment name"
    type = string
    default = "dev"
    
    validation {
      condition = contains(["dev","staging","prod"], environment)
        error_message = "enviroment must be dev. staging, or prod"
    }
}

variable "cluster_name" {
    description = "Name of the EKS cluste"
    type = string
    default = "flask-production-cluster"
}