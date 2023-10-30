resource "google_compute_network" "vpc" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false
  network_firewall_policy_enforcement_order = "BEFORE_CLASSIC_FIREWALL"
}

resource "google_compute_subnetwork" "public" {
  name          = "public"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
}


resource "google_compute_firewall" "ansible_rules" {
  project     = var.project
  name        = "controller-node-rules"
  network     = google_compute_network.vpc.id
  description = "allows ssh access from ansible and jump-server tags"

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }

  source_tags = ["ansible", "jump-server"]
  target_tags = ["ansible"]


}

resource "google_compute_firewall" "jump_server" {
  project     = var.project
  name        = "jump-firewall-rule"
  network     = google_compute_network.vpc.id
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["jump-server"]

  depends_on = [ google_compute_firewall.ansible_rules ]
}
