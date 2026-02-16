output "instance_ip" {
  description = "IP publique de la VM"
  value       = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "instance_name" {
  description = "Nom de l'instance"
  value       = google_compute_instance.vm.name
}