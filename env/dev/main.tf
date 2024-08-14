terraform {
  required_version = ">= 1.9.4, < 2.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.41.0"
    }
  }
}

resource "google_storage_bucket" "random5301270235081" {
  location = "asia-northeast1"
  name     = "random5301270235081"
}
