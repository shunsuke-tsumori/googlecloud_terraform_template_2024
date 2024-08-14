resource "google_storage_bucket" "tfstate_backend" {
  location                    = "asia-northeast1"
  name                        = "tfstate-backend-dev"
  uniform_bucket_level_access = true
}
