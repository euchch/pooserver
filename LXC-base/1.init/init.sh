#!/bin/bash

FILE='/etc/sysctl.conf'

LINE='net.bridge.bridge-nf-call-iptables=1'
if ! grep -qF "$LINE" "$FILE"; then
    echo "$LINE" | tee -a "$FILE"
fi

LINE='net.ipv4.ip_forward=1'
if ! grep -qF "$LINE" "$FILE"; then
    echo "$LINE" | tee -a "$FILE"
fi

sysctl --system

# Possibly need to disable swap - in theory should not be a problem starting k8s 22 - so commented out
# sysctl vm.swappiness=0
# swapoff -a

# Possibly need to enable ip forwarding, since I'm using nginx-ingress maybe not needed - commented out
# sysctl net.ipv4.ip_forward=1
# sysctl net.ipv6.conf.all.forwarding=1
# sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
# sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf
