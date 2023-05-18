variable "proxmox_username" {}
variable "proxmox_password" {}
variable "proxmox_server_endpoint" {}

terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.19.1"
    }
  }
}

provider "proxmox" {
  virtual_environment {
    endpoint = var.proxmox_server_endpoint
    username = var.proxmox_username
    password = var.proxmox_password
    insecure = true
  }
}
