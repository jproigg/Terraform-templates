output "public_ips" {
  value = [for instance in google_compute_instance.ansible_nodes : instance.network_interface[0].access_config[0].nat_ip]
}

