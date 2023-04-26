#!/bin/bash
# This script edits the config files for the containers

# Check if the user is root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Set the container IDs
IDs=(1111 1112)

# Edit the config files for the containers
for ID in "${IDs[@]}"; do
    # Check if the lines already exist in the config file
    if ! grep -q "lxc.apparmor.profile: unconfined" /etc/pve/lxc/$ID.conf; then
        echo "lxc.apparmor.profile: unconfined" >> /etc/pve/lxc/$ID.conf
    fi

    if ! grep -q "lxc.cgroup.devices.allow: a" /etc/pve/lxc/$ID.conf; then
        echo "lxc.cgroup.devices.allow: a" >> /etc/pve/lxc/$ID.conf
    fi

    if ! grep -q "lxc.cap.drop:" /etc/pve/lxc/$ID.conf; then
        echo "lxc.cap.drop:" >> /etc/pve/lxc/$ID.conf
    fi

    if ! grep -q "lxc.mount.auto: \"proc:rw sys:rw\"" /etc/pve/lxc/$ID.conf; then
        echo "lxc.mount.auto: \"proc:rw sys:rw\"" >> /etc/pve/lxc/$ID.conf
    fi
done

echo "The config files for the containers have been edited"
