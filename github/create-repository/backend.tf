resource "github_repository" "repository" {
  name        = var.repository_name
  description = var.repository_description

  visibility = var.visibility
  auto_init   = true
}

resource "github_branch_default" "repository_default_branch" {
  repository = github_repository.repository.name
  branch     = var.default_branch
  rename = true
}

output "ssh_clone_url" {
  value = "git clone ${github_repository.repository.ssh_clone_url}"
}

output "add_remote" {
  value = "git remote add origin ${github_repository.repository.ssh_clone_url}"
}