variable "github_token" {
  type = string
  description = "The GitHub token to use for authentication."
}

variable "repository_name" {
  type = string
  default = "terraform"
  description = "The name of the repository to create."
}

variable "repository_description" {
  type = string
  default = "My awesome repository created with Terraform"
  description = "The description of the repository to create."
}

variable "visibility" {
  type = string
  default = "public"
  description = "The visibility of the repository to create."
}

variable "default_branch" {
  type = string
  default = "dev"
  description = "The default branch of the repository to create."
}
