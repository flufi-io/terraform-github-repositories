repositories = {
  repo1 = {
    name         = "testing-template-repository-jkshdbjk"
    "visibility" = "public"
    description  = "testing template repository"
    "restrictions" = {
      teams = ["@flufi-io/devops-engineers"]
      users = ["pipo-flufi"]
      apps  = []
    }
    "required_pull_request_reviews" = {
      dismissal_teams                 = ["@flufi-io/devops-engineers"]
      dismissal_users                 = ["pipo-flufi"]
      dismiss_stale_reviews           = true
      require_code_owner_reviews      = true
      required_approving_review_count = 1
    }
    "status_checks_contexts" = ["terratest"]
  }
}
