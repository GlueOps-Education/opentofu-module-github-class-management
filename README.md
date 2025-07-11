# opentofu-module-github-class-management
<!-- BEGIN_TF_DOCS -->
# OpenTofu Module: GitHub Class Management Module

This OpenTofu module automates the management of GitHub repositories for educational environments. It creates student repositories from templates and manages student access permissions, making it ideal for instructors managing coding bootcamps, courses, or training programs.

## Features

- **Automated Repository Creation**: Creates individual repositories for each student based on specified templates
- **Template-Based Setup**: Uses GitHub repository templates to ensure consistent starting points for assignments
- **Student Access Management**: Automatically grants appropriate permissions to students for their repositories
- **Inactive Student Handling**: Supports removing student access while preserving their repositories for grading/archival purposes
- **Bulk Operations**: Efficiently manages multiple students and repository templates simultaneously
- **Private by Default**: All student repositories are created as private with vulnerability alerts enabled
- **Lifecycle Protection**: Prevents accidental deletion of student repositories

## Use Cases

- Setting up coding bootcamp assignments with individualized repositories
- Managing classroom environments with template-based projects
- Distributing starter code while maintaining separate workspaces for each student
- Archiving student work while removing active access permissions

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github.github_org"></a> [github.github\_org](#provider\_github.github\_org) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.student_repos](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborator.student_collab](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository_collaborator) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name) | n/a | `string` | n/a | yes |
| <a name="input_inactive_students"></a> [inactive\_students](#input\_inactive\_students) | List of GitHub handles for students who should be removed from repo access but keep their repos | `list(string)` | `[]` | no |
| <a name="input_repo_templates"></a> [repo\_templates](#input\_repo\_templates) | n/a | <pre>list(object({<br/>    owner      = string<br/>    repository = string<br/>    prefix     = string<br/>  }))</pre> | n/a | yes |
| <a name="input_students"></a> [students](#input\_students) | n/a | <pre>list(object({<br/>    github_handle = string<br/>    first_name    = string<br/>    last_name     = string<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->