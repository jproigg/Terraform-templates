terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 4.64.0"
    }
  }

}


provider "google" {
    credentials = file("./scripts/credentials.json")
    project = var.project
    region  = var.region
    zone    = var.zone
  
}













