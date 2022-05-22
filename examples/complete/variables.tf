variable "name" {
  type        = string
  description = "Name of the repository"
}
variable "description" {
  type        = string
  description = "Description of the repository"
}
variable "visibility" {
  type        = string
  description = "Visibility of the repository"
  default     = "private"
}


variable "template_files" {
  type        = list(string)
  description = "List of the paths of the files that will be added in the new repo"
  default     = []
}
variable "template_files_prefix" {
  type        = string
  default     = ""
  description = "Prefix of the file path to be removed in the new repo"
}
variable "status_checks_contexts" {
  default     = []
  type        = list(string)
  description = "Contexts for the status_checks branch protection"
}
variable "required_pull_request_reviews" {
  type = object({
    dismissal_teams                 = list(string)
    dismissal_users                 = list(string)
    dismiss_stale_reviews           = bool
    require_code_owner_reviews      = bool
    required_approving_review_count = number
  })
  description = "Branch protection options to require PR reviews."
}
variable "restrictions" {
  type = object({
    teams = list(string)
    users = list(string)
    apps  = list(string)
  })
  description = "Branch protection,require restrictions (is only available for organization-owned repositories)."
}

variable "github_token" {
  sensitive = true
}
