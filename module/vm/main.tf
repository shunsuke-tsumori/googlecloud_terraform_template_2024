resource "google_compute_instance" "my_vm" {
  name         = "my-vm-${var.env}"
  machine_type = "e2-micro"
  zone         = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.my_subnetwork.id
  }
}
