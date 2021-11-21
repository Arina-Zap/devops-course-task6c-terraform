provider "google" {
	credentials = "${file("crash-course-credentials.json")}"
	project = "crash-course"
	region  = "us-central1"
	zone    = "us-central1-c"
}

resource "google_compute_instance" "nginx_test" {
    name = "nginxserver"
    machine_type = "e2-micro"
    tags = ["http-server"]
    
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-9"
        }
    }

    metadata_startup_script ="${file("nginx.sh")}"

	scheduling {
        preemptible = true
        automatic_restart = false
    }

    network_interface {
        network ="default"
        access_config {
        }
    }
}

resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}
