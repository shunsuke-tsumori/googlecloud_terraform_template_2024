locals {
  services = toset([
    "compute.googleapis.com",
    "iam.googleapis.com",
  ])
}
