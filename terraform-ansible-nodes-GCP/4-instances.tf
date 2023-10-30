resource "google_project_service" "api" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com"
  ])
  disable_on_destroy = false
  service            = each.value
}


resource "google_compute_instance" "ansible_controller" {
  name         = "controller"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20231023"
    }
  }
  network_interface {
    network = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.public.id
    access_config {}    
  }

  tags = ["ansible"]

  
  metadata_startup_script = file("./scripts/ansible_controller.sh")

  depends_on = [google_project_service.api, google_compute_network.vpc, google_compute_instance.ansible_nodes]
}

resource "google_compute_instance" "ansible_nodes" {
  count = 3
  name         = "node-${count.index}"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20231023"
    }
  }
  network_interface {
    network = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.public.id
    access_config {}    
  }

  tags = ["ansible"]

  
  metadata_startup_script = file("./scripts/ansible_nodes.sh")

  depends_on = [google_project_service.api, google_compute_network.vpc]
}

resource "google_compute_instance" "jump_server" {
  name         = "jump-server"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20231023"
    }
  }
  network_interface {
    network = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.public.id
    access_config {}    
  }

  tags = ["jump-server", "ansible"]

  metadata = {
    ssh-keys = file("./keys/gcp-public.pub")
  }

  metadata_startup_script = file("./scripts/jump_server.sh")

  depends_on = [google_project_service.api, google_compute_network.vpc]
}