# main.tf — Configuration Infrastructure AppSec

# ============================================
# 🌐 Réseau VPC Partagé
# ============================================

resource "google_compute_network" "vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

# ============================================
# 🔒 Pare-feu Partagé
# ============================================

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "3000", "3001", "4280", "8080", "8081", "8888", "9090"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-enabled"]
}

# ============================================
# 🖥️ VM Docker - Region europe-west1
# ============================================

resource "google_compute_subnetwork" "subnet" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
}

resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["ssh-enabled"]

  # Disque d'amorcage (boot disk)
  boot_disk {
    initialize_params {
      image   = "projects/${var.image_project}/global/images/family/${var.image_family}"
      size    = 20  # taille en Go
      type    = "pd-standard"
    }
    auto_delete = true
  }

  # Interface réseau avec IP externe
  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id

    # Assigne une IP externe (éphémère)
    access_config {}
  }

  # Métadonnées : clé SSH pour l'accès
  metadata = {
    ssh-keys = "${var.ssh_username}:${var.ssh_public_key}"
  }
}