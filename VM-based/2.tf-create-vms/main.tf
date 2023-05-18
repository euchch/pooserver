variable "proxmox_node_name" {}
variable "alpine_image" {}

resource "random_password" "master_container_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "tls_private_key" "master_container_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "random_password" "worker_container_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "tls_private_key" "worker_container_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "proxmox_virtual_environment_file" "alpine_iso" {
  content_type = "iso"
  datastore_id = "local"
  node_name = var.proxmox_node_name

  source_file {
    path = var.alpine_image
  }
}

output "master_container_password" {
  value     = random_password.master_container_password.result
  sensitive = true
}

output "worker_container_password" {
  value     = random_password.worker_container_password.result
  sensitive = true
}

output "master_container_private_key" {
  value     = tls_private_key.master_container_key.private_key_pem
  sensitive = true
}

output "worker_container_private_key" {
  value     = tls_private_key.worker_container_key.private_key_pem
  sensitive = true
}
