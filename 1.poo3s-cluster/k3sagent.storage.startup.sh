#!/bin/bash

# nfs-common should be installed on agent
apk add nfs-utils
rc-update add nfsmount
rc-service nfsmount start

if ! grep -qs '/mnt/srv/local ' /proc/mounts; then
    mkdir -p /mnt/srv/temp
    NFS_SERVER=poove1.poos.home
    NFS_DIR=/srv
    mount -t nfs ${NFS_SERVER}:${NFS_DIR} /mnt/srv/temp
    mkdir -p /mnt/srv/temp/$(hostname)
    umount -l /mnt/srv/temp

    mkdir -p /mnt/srv/local
    NFS_DIR=/srv/$(hostname)
    mount -t nfs ${NFS_SERVER}:${NFS_DIR} /mnt/srv/local
    echo "${NFS_SERVER}:${NFS_DIR} /mnt/srv/local nfs _netdev 0 0" | tee -a /etc/fstab
fi

if ! grep -qs '/mnt/srv/shared ' /proc/mounts; then
    mkdir -p /mnt/srv/shared

    NFS_SERVER=poove1.poos.home
    NFS_DIR=/srv/shared
    mount -t nfs ${NFS_SERVER}:${NFS_DIR} /mnt/srv/shared
    echo "${NFS_SERVER}:${NFS_DIR} /mnt/srv/shared nfs _netdev 0 0" | tee -a /etc/fstab
fi
