data "google_project" "current" {}

resource "google_iam_workload_identity_pool" "pool" {
  workload_identity_pool_id = "github-pool"
  display_name              = "github-pool"
  description               = "for github actions workflows"
}

locals {
  my_github_repository_owner = "shunsuke-tsumori"
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  workload_identity_pool_id = google_iam_workload_identity_pool.pool.workload_identity_pool_id

  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "github-provider"
  description                        = "for github actions workflows"

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = "assertion.repository_owner == '${local.my_github_repository_owner}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
