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
# 🖥️ VM Docker - Region europe-west1
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
  description = "Nom de la VM Docker"
  type        = string
  default     = "vm-docker-appsec"
}