resource "google_compute_instance" "nginx_test" {
    project = var.project_id
    name = var.vm_name
    machine_type = var.vm_type
    zone    = var.zone
    tags = var.tags
    
    boot_disk {
        initialize_params {
            image = var.vm_image
        }
    }

    metadata_startup_script = file("nginx.sh")

	scheduling {
        preemptible = true
        automatic_restart = false
    }

    network_interface {
        network = var.vm_network
        access_config {
        }
    }
}

resource "google_compute_firewall" "http-server" {
  project = var.project_id
  name    = var.fw_allow_rule["name"]
  network = var.vm_network

  allow {
    protocol = var.fw_allow_rule["protocol"]
    ports    = var.fw_allow_rule["ports"]
  }
  source_ranges = var.fw_allow_rule["source_ranges"]
  target_tags   = var.tags
}
