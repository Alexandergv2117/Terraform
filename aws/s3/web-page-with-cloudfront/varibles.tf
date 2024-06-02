variable "access_key" {
  type = string
  description = "AWS access key"
}

variable "secret_key" {
  type = string
  description = "AWS secret key"
}

variable "region" {
  type = string
  default = "us-east-1"
  description = "AWS region"
}

variable "bucket_name" {
  type = string
  description = "S3 bucket name"
}

variable "role_name" {
  default = "github-actions-role-app-dev"
  type = string
  description = "IAM role name"
}

variable "repo_owner" {
  type = string
  description = "GitHub repository owner"
}

variable "repo_name" {
  type = string
  description = "GitHub repository name"  
}
