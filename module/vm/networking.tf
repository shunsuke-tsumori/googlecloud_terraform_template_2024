resource "google_compute_network" "my_network" {
  name                    = "my-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my_subnetwork" {
  name          = "my-subnetwork"
  ip_cidr_range = "10.0.0.0/24"
  region        = "asia-northeast1"
  network       = google_compute_network.my_network.id
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.my_network.id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}
