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
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-enabled"]
}

# ============================================
# 🖥️ VM1 - Region 1 (europe-west1)
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

# ============================================
# 🖥️ VM2 - Region 2 (us-central1)
# ============================================

resource "google_compute_subnetwork" "subnet2" {
  name          = "my-subnet-2"
  ip_cidr_range = "10.1.0.0/24"
  region        = var.region2
  network       = google_compute_network.vpc.id
}

resource "google_compute_instance" "vm2" {
  name         = var.instance_name2
  machine_type = var.machine_type
  zone         = var.zone2

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
    subnetwork = google_compute_subnetwork.subnet2.id

    # Assigne une IP externe (éphémère)
    access_config {}
  }

  # Métadonnées : clé SSH pour l'accès
  metadata = {
    ssh-keys = "${var.ssh_username}:${var.ssh_public_key}"
  }
}

# ============================================
# 🖥️ VM3 - Region 3 (europe-west9 - Paris)
# ============================================

resource "google_compute_subnetwork" "subnet3" {
  name          = "my-subnet-3"
  ip_cidr_range = "10.2.0.0/24"
  region        = var.region3
  network       = google_compute_network.vpc.id
}

resource "google_compute_instance" "vm3" {
  name         = var.instance_name3
  machine_type = var.machine_type
  zone         = var.zone3

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
    subnetwork = google_compute_subnetwork.subnet3.id

    # Assigne une IP externe (éphémère)
    access_config {}
  }

  # Métadonnées : clé SSH pour l'accès
  metadata = {
    ssh-keys = "${var.ssh_username}:${var.ssh_public_key}"
  }
}