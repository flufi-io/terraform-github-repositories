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
