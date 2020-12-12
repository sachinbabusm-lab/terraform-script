
provider "google"{
  project = "clean-yew-297908"
}

resource "google_compute_instance" "gcp_instance" {
  name = "terraform-instance"
  zone = "us-central1-a"
  machine_type = "n1-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
  }
}
