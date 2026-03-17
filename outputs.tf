output "instance_ip" {
  description = "IP publique de la VM"
  value       = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "instance_name" {
  description = "Nom de l'instance"
  value       = google_compute_instance.vm.name
}

output "instance2_ip" {
  description = "IP publique de la deuxième VM"
  value       = google_compute_instance.vm2.network_interface[0].access_config[0].nat_ip
}

output "instance2_name" {
  description = "Nom de la deuxième instance"
  value       = google_compute_instance.vm2.name
}

output "instance3_ip" {
  description = "IP publique de la troisième VM (Docker/httpbin)"
  value       = google_compute_instance.vm3.network_interface[0].access_config[0].nat_ip
}

output "instance3_name" {
  description = "Nom de la troisième instance"
  value       = google_compute_instance.vm3.name
}