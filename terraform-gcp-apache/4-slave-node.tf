
resource "google_compute_instance" "slave_node" {
  name         = "jenkins-slave"
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

    
  tags = ["jenkins-slave"]
  
  metadata_startup_script = file("./scripts/bash1.sh")

  depends_on = [google_project_service.api, google_compute_network.vpc]
}