locals {
  my_github_repository = "shunsuke-tsumori/googlecloud_terraform_template_2024"
}

resource "google_project_iam_member" "wif_principal" {
  for_each = toset([
    "roles/compute.networkAdmin",
    "roles/compute.instanceAdmin.v1",
  ])
  project = data.google_project.current.project_id
  role    = each.value
  member  = "principal://iam.googleapis.com/projects/${data.google_project.current.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.pool.workload_identity_pool_id}/subject/${local.my_github_repository}"
}
