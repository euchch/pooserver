variable "proxmox_node_name" {}
variable "proxmox_ct_storage" {}
variable "proxmox_storage" {}

variable "master_vm_id" {}
variable "master_ip" {}

variable "slave_vm_id" {}
variable "slave_ip" {}

variable "slave_2_vm_id" {}
variable "slave_2_ip" {}

variable "lxc_rocky_container_image" {}
variable "lxc_debian_container_image" {}
variable "lxc_alpine_container_image" {}
variable "network_gateway" {}

resource "proxmox_virtual_environment_container" "master_container" {
  description  = "Managed by Terraform"
  node_name    = var.proxmox_node_name
  vm_id        = var.master_vm_id
  unprivileged = false

  initialization {
    hostname = "poove2-poo3s-master-1"

    ip_config {
      ipv4 {
        address = var.master_ip
        gateway = var.network_gateway
      }
    }
    user_account {
      keys     = [trimspace(tls_private_key.master_container_key.public_key_openssh)]
      password = random_password.master_container_password.result
    }
  }

  network_interface {
    name = "veth0"
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_file.debian_container_template.id
    type             = "debian"
  }

  disk {
    datastore_id = var.proxmox_storage
    size = 20
  }

  cpu {
    cores = 2
  }
  
  memory {
    dedicated = 1536
  }
  features {
    nesting = true
  }
}

resource "proxmox_virtual_environment_container" "slave_container" {
  description = "Managed by Terraform"
  node_name   = var.proxmox_node_name
  vm_id       = var.slave_vm_id
  unprivileged = false

  initialization {
    hostname = "poove2-poo3s-worker-1"

    ip_config {
      ipv4 {
        address = var.slave_ip
        gateway = var.network_gateway
      }
    }

    user_account {
      keys     = [trimspace(tls_private_key.slave_container_key.public_key_openssh)]
      password = random_password.slave_container_password.result
    }
  }

  network_interface {
    name = "veth0"
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_file.debian_container_template.id
    type             = "debian"
  }


  disk {
    datastore_id = var.proxmox_storage
    size = 20
  }

  cpu {
    cores = 2
  }
  
  memory {
    dedicated = 1536
  }
  features {
    nesting = true
  }
}

resource "proxmox_virtual_environment_container" "slave_2_container" {
  description  = "Managed by Terraform"
  node_name    = var.proxmox_node_name
  vm_id        = var.slave_2_vm_id
  unprivileged = false

  initialization {
    hostname = "poove2-poo3s-worker-2"

    ip_config {
      ipv4 {
        address = var.slave_2_ip
        gateway = var.network_gateway
      }
    }

    user_account {
      keys     = [trimspace(tls_private_key.slave_container_key.public_key_openssh)]
      password = random_password.slave_container_password.result
    }
  }

  network_interface {
    name = "veth0"
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_file.debian_container_template.id
    type             = "debian"
  }


  disk {
    datastore_id = var.proxmox_storage
    size = 20
  }

  cpu {
    cores = 2
  }
  
  memory {
    dedicated = 1536
  }
  features {
    nesting = true
  }
}

resource "proxmox_virtual_environment_file" "debian_container_template" {
  content_type = "vztmpl"
  datastore_id = var.proxmox_ct_storage
  node_name    = var.proxmox_node_name

  source_file {
    path = var.lxc_debian_container_image
  }
}

resource "proxmox_virtual_environment_file" "rocky_container_template" {
  content_type = "vztmpl"
  datastore_id = var.proxmox_ct_storage
  node_name    = var.proxmox_node_name

  source_file {
    path = var.lxc_rocky_container_image
  }
}

resource "proxmox_virtual_environment_file" "alpine_container_template" {
  content_type = "vztmpl"
  datastore_id = var.proxmox_ct_storage
  node_name    = var.proxmox_node_name

  source_file {
    path = var.lxc_alpine_container_image
  }
}

resource "random_password" "master_container_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "tls_private_key" "master_container_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

output "master_container_password" {
  value     = random_password.master_container_password.result
  sensitive = true
}

output "master_container_private_key" {
  value     = tls_private_key.master_container_key.private_key_pem
  sensitive = true
}

output "master_container_public_key" {
  value = tls_private_key.master_container_key.public_key_openssh
}

resource "random_password" "slave_container_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "tls_private_key" "slave_container_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

output "ct_id" {
  value = proxmox_virtual_environment_file.rocky_container_template.id
}

output "slave_container_password" {
  value     = random_password.slave_container_password.result
  sensitive = true
}

output "slave_container_private_key" {
  value     = tls_private_key.slave_container_key.private_key_pem
  sensitive = true
}

output "slave_container_public_key" {
  value = tls_private_key.slave_container_key.public_key_openssh
}
