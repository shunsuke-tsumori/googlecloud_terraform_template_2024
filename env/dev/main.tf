terraform {
  backend "gcs" {
    bucket = "tfstate-backend-dev"
    prefix = "dev"
  }
  required_version = ">= 1.9.4, < 2.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.41.0"
    }
  }
}

resource "google_project_service" "service" {
  for_each           = local.services
  service            = each.value
  disable_on_destroy = false
}

module "vm" {
  source = "../../module/vm"

  env = local.env
}

module "wif" {
  source = "../../module/wif"

  env                 = local.env
  backend_bucket_name = google_storage_bucket.tfstate_backend.name
}
