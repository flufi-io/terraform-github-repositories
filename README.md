# terraform-module-template

<!-- BEGIN_TF_DOCS -->
# Examples
```hcl
#locals {
#  template_files = [
#    "../../.terraform/modules/template/.terraform/modules/template/.config/.terraform-docs.yml",
#
#    "../../.terraform/modules/template/.github/workflows/tfsec.yml",
#    "../../.terraform/modules/template/.github/workflows/terrascan.yml",
#    "../../.terraform/modules/template/.gitignore",
#    "../../.terraform/modules/template/main.tf",
#    "../../.terraform/modules/template/variables.tf",
#    "../../.terraform/modules/template/versions.tf",
#    "../../.terraform/modules/template/outputs.tf",
#    "../../.terraform/modules/template/README.md",
#
#    "../../.terraform/modules/template/examples/complete/main.tf",
#    "../../.terraform/modules/template/examples/complete/variables.tf",
#    "../../.terraform/modules/template/examples/complete/versions.tf",
#    "../../.terraform/modules/template/examples/complete/outputs.tf",
#    "../../.terraform/modules/template/examples/complete/terraform.tfvars",
#    "../../.terraform/modules/template/examples/complete/providers.tf",
#
#    "../../.terraform/modules/template/tests/complete/complete_test.go",
#  ]
#  template_files_prefix = "../../.terraform/modules/template/"
#}
#module "template" {
#  source = "git@github.com:flufi-io/terraform-module-template.git?ref=2-terraform-module-template"
#}
#
#
#module "repository" {
#  source      = "flufi-io/repository/github"
#  version     = "0.0.1"
#  name        = var.name
#  description = var.description
#  #checkov:skip=CKV_GIT_1: The repository must be public
#  visibility            = var.visibility
#  template_files        = var.template_files
#  template_files_prefix = var.template_files_prefix
#  #checkov:skip=CKV_GIT_5: Only one approving reviews for PRs
#  required_pull_request_reviews = var.required_pull_request_reviews
#  restrictions                  = var.restrictions
#  status_checks_contexts        = var.status_checks_contexts
#  reposi
#}

locals {
  ignore_git_files = tolist(fileset(".terraform/modules/template/", ".git/**"))
  template_files   = setsubtract(tolist(fileset(".terraform/modules/template/", "**")), local.ignore_git_files)

  template_files_prefix = ".terraform/modules/template/"

  repositories = {
    terraform-dummy-repository = {
      name        = "terraform-dummy-repository"
      description = "dummy repository"
    }
  }
  defaults = {
    visibility = "private"
    restrictions = {
      teams = ["@flufi-io/devops-engineers"]
      users = ["pipo-flufi"]
      apps  = []
    }
    required_pull_request_reviews = {
      dismissal_teams                 = ["@flufi-io/devops-engineers"]
      dismissal_users                 = ["pipo-flufi"]
      dismiss_stale_reviews           = true
      require_code_owner_reviews      = true
      required_approving_review_count = 1
    }
    status_checks_contexts = ["terratest", "terraform-validate", "tfscan", "terrascan", "infracost"]

  }
}


module "template" {
  source  = "flufi-io/template/module"
  version = "0.0.1"
}




module "repository_from_template" {
  source      = "flufi-io/repository/github"
  version     = "0.0.3"
  for_each    = tomap(var.repositories)
  name        = each.value["name"]
  description = each.value["description"]
  #checkov:skip=CKV_GIT_1: The repository must be public
  #ts:skip=AC_GITHUB_0002
  visibility            = try(each.value["visibility"], local.defaults.visibility)
  template_files        = local.template_files
  template_files_prefix = local.template_files_prefix
  #checkov:skip=CKV_GIT_5: Only one approving reviews for PRs
  required_pull_request_reviews = try(each.value["required_pull_request_reviews"], local.defaults.required_pull_request_reviews)
  restrictions                  = try(each.value["restrictions"], local.defaults.restrictions)
  status_checks_contexts        = try(each.value["status_checks_contexts"], local.defaults.status_checks_contexts)
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repositories"></a> [repositories](#input\_repositories) | Repositories configuration | `any` | `[]` | no |
| <a name="input_required_pull_request_reviews"></a> [required\_pull\_request\_reviews](#input\_required\_pull\_request\_reviews) | Branch protection options to require PR reviews. | `string` | `""` | no |
| <a name="input_restrictions"></a> [restrictions](#input\_restrictions) | Branch protection,require restrictions (is only available for organization-owned repositories). | `string` | `""` | no |
| <a name="input_status_checks_contexts"></a> [status\_checks\_contexts](#input\_status\_checks\_contexts) | Contexts for the status\_checks branch protection | `list(string)` | `[]` | no |
| <a name="input_template_files"></a> [template\_files](#input\_template\_files) | List of the paths of the files that will be added in the new repo | `list(string)` | `[]` | no |
| <a name="input_template_files_prefix"></a> [template\_files\_prefix](#input\_template\_files\_prefix) | Prefix of the file path to be removed in the new repo | `string` | `""` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Visibility of the repository | `string` | `"private"` | no |

## Resources

<!-- END_TF_DOCS -->
