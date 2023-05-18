master_name             = "poove2-poo3s-master-1"
worker_1_name           = "poove2-poo3s-worker-1"
worker_2_name           = "poove2-poo3s-worker-2"
target_node             = "poove2"
alpine_image            = "https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/x86_64/alpine-virt-3.18.0-x86_64.iso"
master_cpu              = "1"
master_mem              = "1024"
worker_cpu              = "2"
worker_mem              = "2048"
vm_hdd_size             = "20"
master_ip               = "192.168.1.87"
worker_1_ip             = "192.168.1.88"
worker_2_ip             = "192.168.1.88"
master_vmid             = "101"
worker_1_vmid           = "111"
worker_2_vmid           = "112"
proxmox_server_endpoint = "https://poove2.poos.home:8006/"
proxmox_node_name       = "poove2"
proxmox_url             = "poove2.poos.home"
