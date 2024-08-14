locals {
  my_github_repository = "googlecloud_terraform_template_2024"
}

resource "google_project_iam_member" "wif_principal" {
  for_each = toset([
    "roles/compute.networkAdmin",
    "roles/compute.instanceAdmin.v1",
    "roles/editor",
  ])
  project = data.google_project.current.project_id
  role    = each.value
  member  = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.pool.name}/attribute.repository/${local.my_github_repository}"
}

resource "google_storage_bucket_iam_member" "backend_viewer" {
  bucket = var.backend_bucket_name
  role   = "roles/storage.objectViewer"
  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.pool.name}/attribute.repository/${local.my_github_repository}"
}
