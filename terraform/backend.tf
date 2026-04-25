terraform {
  backend "s3" {
    bucket ="my-terrafrom-state-bucket-123"
    key="eks-project/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-locks" 
 
  }
}