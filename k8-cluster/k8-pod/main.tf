provider "google" {
  project = "clean-yew-297908"
}

data "google_container_cluster" "primary" {
  name = "k8-cluster"
  location = "us-east1-d"
}

provider "kubernetes" {
  load_config_file = false
  username = data.google_container_cluster.primary.master_auth.0.username
  password = data.google_container_cluster.primary.master_auth.0.password
  host = data.google_container_cluster.primary.endpoint
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  client_certificate = base64decode(data.google_container_cluster.primary.master_auth.0.client_certificate)
  client_key = base64decode(data.google_container_cluster.primary.master_auth.0.client_key)
}

resource "kubernetes_deployment" "hello_world" {
  metadata {
    name = "k8-pod"
  }
  spec {
    template {
      metadata {}
      spec {
        container {
          name = "docker"
          image = "us.gcr.io/clean-yew-297908/app:latest"
          image_pull_policy = "Always"
          port {
            container_port = 4000
          }
        }
      }
    }
  }
}
terraform {
  backend "gcs" {
    bucket = "sachin-terraform"
    prefix = "k8-pod"
  }
}