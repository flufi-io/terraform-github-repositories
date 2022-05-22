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
  #ts:skip=AC_GITHUB_0002
  source      = "flufi-io/repository/github"
  version     = "0.0.3"
  for_each    = tomap(var.repositories)
  name        = each.value.name
  description = each.value.description
  #checkov:skip=CKV_GIT_1: The repository must be public
  #ts:skip=AC_GITHUB_0002
  visibility            = try(each.value.visibility, local.defaults.visibility)
  template_files        = local.template_files
  template_files_prefix = local.template_files_prefix
  #checkov:skip=CKV_GIT_5: Only one approving reviews for PRs
  required_pull_request_reviews = try(each.value.required_pull_request_reviews, local.defaults.required_pull_request_reviews)
  restrictions                  = try(each.value.restrictions, local.defaults.restrictions)
  status_checks_contexts        = try(each.value.status_checks_contexts, local.defaults.status_checks_contexts)
}
