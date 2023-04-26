#!/bin/bash

# Set the tfstate file path
TFSTATE_FILE="../2.tf-create-lxc/terraform.tfstate"

# Extract the private_key_pem value from the tfstate file
PRIVATE_KEY=$(jq -r '.resources[] | select(.type == "tls_private_key") | select(.name == "master_container_key") | .instances[0].attributes.private_key_pem' $TFSTATE_FILE)

# Write the private key to a file
echo "$PRIVATE_KEY" > master_container_private_key.pem

# Set appropriate permissions for the private key file
chmod 600 master_container_private_key.pem

PRIVATE_KEY=$(jq -r '.resources[] | select(.type == "tls_private_key") | select(.name == "slave_container_key") | .instances[0].attributes.private_key_pem' $TFSTATE_FILE)

# Write the private key to a file
echo "$PRIVATE_KEY" > slave_container_private_key.pem

# Set appropriate permissions for the private key file
chmod 600 slave_container_private_key.pem

# Set the hostname to search for
HOSTNAME="poove2-poo3s-master-1"

# Extract the IPv4 address from the tfstate file
MASTER_IP_ADDRESS=$(jq -r --arg hostname "$HOSTNAME" '.resources[].instances[] | select(.attributes.initialization[0].hostname == $hostname) | .attributes.initialization[0].ip_config[0].ipv4[0].address' $TFSTATE_FILE)
MASTER_IP_ADDRESS=$(echo "$MASTER_IP_ADDRESS" | cut -d '/' -f 1)

HOSTNAME="poove2-poo3s-worker-1"
# Extract the IPv4 address from the tfstate file
WORKER_IP_ADDRESS=$(jq -r --arg hostname "$HOSTNAME" '.resources[].instances[] | select(.attributes.initialization[0].hostname == $hostname) | .attributes.initialization[0].ip_config[0].ipv4[0].address' $TFSTATE_FILE)
WORKER_IP_ADDRESS=$(echo "$WORKER_IP_ADDRESS" | cut -d '/' -f 1)

# Create the directories if they don't exist
mkdir -p inventory/my-cluster/group_vars

# Write the content to the file
cat > inventory/my-cluster/hosts.ini << EOF
[master]
${MASTER_IP_ADDRESS} Ansible_ssh_private_key_file=master_container_private_key.pem
[node]
${WORKER_IP_ADDRESS} Ansible_ssh_private_key_file=slave_container_private_key.pem

[k3s_cluster:children]
master
node
EOF

# Ansible-playbook site.yml -i inventory/my-cluster/hosts.ini -u root
