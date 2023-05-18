# Poove2 server details
proxmox_server_endpoint = "https://poove2.poos.home:8006/"
proxmox_node_name = "poove2"
proxmox_ct_storage = "local"
proxmox_storage = "local-zfs"

# poove2 nodes
master_vm_id     = 1111
master_ip        = "192.168.1.87/24"

slave_vm_id      = 1112
slave_ip         = "192.168.1.88/24"

slave_2_vm_id    = 1113
slave_2_ip       = "192.168.1.89/24"

# Network details
lxc_rocky_container_image = "http://download.proxmox.com/images/system/rockylinux-9-default_20221109_amd64.tar.xz"
lxc_debian_container_image = "http://download.proxmox.com/images/system/debian-11-standard_11.6-1_amd64.tar.zst"
lxc_alpine_container_image = "http://download.proxmox.com/images/system/alpine-3.17-default_20221129_amd64.tar.xz"
network_gateway = "192.168.1.1"