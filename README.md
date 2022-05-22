# terraform-module-template

<!-- BEGIN_TF_DOCS -->
# Examples
```hcl
locals {
  template_files = [
    "../../.terraform/modules/template/.terraform/modules/template/.config/.terraform-docs.yml",

    "../../.terraform/modules/template/.github/workflows/tfsec.yml",
    "../../.terraform/modules/template/.github/workflows/terrascan.yml",
    "../../.terraform/modules/template/.gitignore",
    "../../.terraform/modules/template/main.tf",
    "../../.terraform/modules/template/variables.tf",
    "../../.terraform/modules/template/versions.tf",
    "../../.terraform/modules/template/outputs.tf",
    "../../.terraform/modules/template/README.md",

    "../../.terraform/modules/template/examples/complete/main.tf",
    "../../.terraform/modules/template/examples/complete/variables.tf",
    "../../.terraform/modules/template/examples/complete/versions.tf",
    "../../.terraform/modules/template/examples/complete/outputs.tf",
    "../../.terraform/modules/template/examples/complete/terraform.tfvars",
    "../../.terraform/modules/template/examples/complete/providers.tf",

    "../../.terraform/modules/template/tests/complete/complete_test.go",
  ]
  template_files_prefix = "../../.terraform/modules/template/"
}
module "template" {
  source = "git@github.com:flufi-io/terraform-module-template.git?ref=2-terraform-module-template"
}


module "repository" {
  source      = "flufi-io/repository/github"
  version     = "0.0.1"
  name        = var.name
  description = var.description
  #checkov:skip=CKV_GIT_1: The repository must be public
  visibility            = var.visibility
  template_files        = var.template_files
  template_files_prefix = var.template_files_prefix
  #checkov:skip=CKV_GIT_5: Only one approving reviews for PRs
  required_pull_request_reviews = var.required_pull_request_reviews
  restrictions                  = var.restrictions
  status_checks_contexts        = var.status_checks_contexts
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the repository | `string` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | n/a | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the repository | `string` | n/a | yes |
| <a name="input_required_pull_request_reviews"></a> [required\_pull\_request\_reviews](#input\_required\_pull\_request\_reviews) | Branch protection options to require PR reviews. | <pre>object({<br>    dismissal_teams                 = list(string)<br>    dismissal_users                 = list(string)<br>    dismiss_stale_reviews           = bool<br>    require_code_owner_reviews      = bool<br>    required_approving_review_count = number<br>  })</pre> | n/a | yes |
| <a name="input_restrictions"></a> [restrictions](#input\_restrictions) | Branch protection,require restrictions (is only available for organization-owned repositories). | <pre>object({<br>    teams = list(string)<br>    users = list(string)<br>    apps  = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_status_checks_contexts"></a> [status\_checks\_contexts](#input\_status\_checks\_contexts) | Contexts for the status\_checks branch protection | `list(string)` | `[]` | no |
| <a name="input_template_files"></a> [template\_files](#input\_template\_files) | List of the paths of the files that will be added in the new repo | `list(string)` | `[]` | no |
| <a name="input_template_files_prefix"></a> [template\_files\_prefix](#input\_template\_files\_prefix) | Prefix of the file path to be removed in the new repo | `string` | `""` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Visibility of the repository | `string` | `"private"` | no |

## Resources

<!-- END_TF_DOCS -->
