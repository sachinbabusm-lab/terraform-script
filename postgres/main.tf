provider "google"{
  project = "clean-yew-297908"
}

resource "google_sql_database_instance" "sql_instance" {
  region = ""
  name = ""
  database_version = ""
  settings {
    tier = ""
  }
}

terraform {
  backend "gcs" {
    bucket = "sachin-terraform"
    prefix = "postgres/"
  }
}
// importing the state file for already created sql instance
//terraform import google_sql_database_instance.sql_instance clean-yew-297908/postgresql
