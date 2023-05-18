variable "master_name" {}
variable "worker_1_name" {}
variable "worker_2_name" {}
variable "target_node" {}
variable "master_cpu" {}
variable "master_mem" {}
variable "worker_cpu" {}
variable "worker_mem" {}
variable "vm_hdd_size" {}
variable "master_ip" {}
variable "worker_1_ip" {}
variable "worker_2_ip" {}
variable "master_vmid" {}
variable "worker_1_vmid" {}
variable "worker_2_vmid" {}

resource "proxmox_virtual_environment_vm" "master" {
  vm_id     = var.master_vmid
  name      = var.master_name
  node_name = var.target_node
  agent {
    enabled = true
  }
  cpu {
    cores   = var.master_cpu
    sockets = 1
    type    = "host"
  }
  disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    size         = var.vm_hdd_size
  }
  initialization {
    ip_config {
      ipv4 {
        address = var.master_ip
      }
    }
    user_account {
      keys = [
        tls_private_key.master_container_key.public_key_openssh,
      ]
      password = random_password.master_container_password.result
      username = "root"
    }
  }
  iso_path    = var.alpine_image
  iso_storage = "local"
  memory {
    dedicated = var.master_mem
  }
}

resource "proxmox_virtual_environment_vm" "worker_1" {
  vm_id     = var.worker_1_vmid
  name      = var.worker_1_name
  node_name = var.target_node
  agent {
    enabled = true
  }
  cpu {
    cores   = var.worker_cpu
    sockets = 1
    type    = "host"
  }
  disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    size         = var.vm_hdd_size
  }
  initialization {
    ip_config {
      ipv4 {
        address = var.worker_1_ip
      }
    }
    user_account {
      keys     = [tls_private_key.worker_container_key.public_key_openssh]
      password = random_password.worker_container_password.result
      username = "root"
    }
  }
  iso_path    = var.alpine_image
  iso_storage = "local"
  memory { dedicated = var.worker_mem }
}

resource "proxmox_virtual_environment_vm" "worker_2" {
  vm_id     = var.worker_2_vmid
  name      = var.worker_2_name
  node_name = var.target_node
  agent { enabled = true }
  cpu {
    cores   = var.worker_cpu
    sockets = 1
    type    = "host"
  }
  disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    size         = var.vm_hdd_size
  }
  initialization {
    ip_config {
      ipv4 {
        address = var.worker_2_ip
      }
    }
    user_account {
      keys     = [tls_private_key.worker_container_key.public_key_openssh]
      password = random_password.worker_container_password.result
      username = "root"
    }
  }
  iso_path    = var.alpine_image
  iso_storage = "local"
  memory { dedicated = var.worker_mem }
}