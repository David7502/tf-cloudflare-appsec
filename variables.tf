# ============================================
# 🌐 Variables Globales / Partagées
# ============================================

variable "project_id" {
  description = "ID du projet GCP"
  type        = string
}

variable "machine_type" {
  description = "Type de machine (ex : e2-medium)"
  type        = string
  default     = "e2-medium"
}

variable "image_project" {
  description = "Projet de l'image machine"
  type        = string
  default     = "debian-cloud"
}

variable "image_family" {
  description = "Famille d'image (ex : debian-12)"
  type        = string
  default     = "debian-12"
}

variable "ssh_username" {
  description = "Nom d'utilisateur pour SSH"
  type        = string
  default     = "david"
}

variable "ssh_public_key" {
  description = "Clé publique SSH pour l'accès à la VM"
  type        = string
}

# ============================================
# 🖥️ VM1 - Region 1 (europe-west1)
# ============================================

variable "region" {
  description = "Région GCP (ex : europe-west1)"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "Zone GCP (ex : europe-west1-b)"
  type        = string
  default     = "europe-west1-b"
}

variable "instance_name" {
  description = "Nom de la VM"
  type        = string
  default     = "my-vm-terraform"
}

# ============================================
# 🖥️ VM2 - Region 2 (us-central1)
# ============================================

variable "region2" {
  description = "Deuxième région GCP (ex : us-central1)"
  type        = string
  default     = "us-central1"
}

variable "zone2" {
  description = "Deuxième zone GCP pour la VM2 (ex : us-central1-a)"
  type        = string
  default     = "us-central1-a"
}

variable "instance_name2" {
  description = "Nom de la deuxième VM"
  type        = string
  default     = "my-vm-terraform-2"
}

# ============================================
# 🖥️ VM3 - Region 3 (europe-west9 - Paris)
# ============================================

variable "region3" {
  description = "Troisième région GCP (ex : europe-west9)"
  type        = string
  default     = "europe-west9"
}

variable "zone3" {
  description = "Troisième zone GCP pour la VM3 (ex : europe-west9-a)"
  type        = string
  default     = "europe-west9-a"
}

variable "instance_name3" {
  description = "Nom de la troisième VM"
  type        = string
  default     = "my-vm-terraform-3"
}