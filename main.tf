variable "github_organization_name" {
  type = string
}

provider "github" {
  owner = var.github_organization_name
  alias = "github_org"
}

variable "repo_templates" {
  type = list(object({
    owner      = string
    repository = string
    prefix     = string
  }))
}

variable "students" {
  type = list(object({
    github_handle = string
    first_name    = string
    last_name     = string
  }))
}

# New variable to manage student access
variable "inactive_students" {
  type        = list(string)
  description = "List of GitHub handles for students who should be removed from repo access but keep their repos"
  default     = []
}

locals {
  # Create repos for ALL students (active and inactive)
  repo_matrix = flatten([
    for template in var.repo_templates : [
      for student in var.students : {
        repo_name      = "${template.prefix}-${student.first_name}-${student.last_name}"
        template_owner = template.owner
        template_repo  = template.repository
        student_handle = student.github_handle
        first_name     = student.first_name
        last_name      = student.last_name
      }
    ]
  ])

  # Only give access to ACTIVE students
  active_collaborators = [
    for repo in local.repo_matrix : repo
    if !contains(var.inactive_students, repo.student_handle)
  ]
}

resource "github_repository" "student_repos" {
  provider = github.github_org
  for_each = {
    for repo in local.repo_matrix : repo.repo_name => repo
  }

  name                 = each.value.repo_name
  description          = "Repo for ${each.value.first_name} ${each.value.last_name} (${each.value.student_handle}) from template ${each.value.template_repo}"
  visibility           = "private"
  vulnerability_alerts = true

  template {
    owner      = each.value.template_owner
    repository = each.value.template_repo
  }

  # Prevent accidental deletion when removing students
  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository_collaborator" "student_collab" {
  provider = github.github_org

  for_each = {
    for repo in local.active_collaborators : repo.repo_name => repo
  }

  repository = each.value.repo_name
  username   = each.value.student_handle
  permission = "push"

  depends_on = [github_repository.student_repos]
}
