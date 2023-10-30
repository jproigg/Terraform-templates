resource "google_project_service" "api" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com"
  ])
  disable_on_destroy = false
  service            = each.value
}


resource "google_compute_instance" "jenkins-server" {
  name         = "jenkins"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20230918"
    }
  }
  network_interface {
    network = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.public.id
    access_config {}    
  }

  tags = ["jenkins"]

  
  metadata_startup_script = file("./scripts/bash.sh")

  depends_on = [google_project_service.api, google_compute_network.vpc]
}
