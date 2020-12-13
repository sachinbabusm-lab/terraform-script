provider "google" {
  project = "clean-yew-297908"
}

resource "random_password" "random" {
  length = 16
}
resource "google_container_cluster" "primary" {
  name = "k8-cluster"
  location = "us-east1-d"
  master_auth {
    username = "sachin"
    password = random_password.random.result
    client_certificate_config {
      issue_client_certificate = true
    }
  }
  node_pool {
    initial_node_count = 1
    node_config {
      image_type = "ubuntu"
      machine_type = "e2-medium"
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  }
}

terraform {
  backend "gcs" {
    bucket = "sachin-terraform"
    prefix = "k8"
  }
}