cat <<EOF > ~/answers.txt
KEYMAPOPTS="us us"
HOSTNAMEOPTS="-n myhostname"
INTERFACESOPTS="auto lo
iface lo inet loopback

auto veth0
iface veth0 inet static
    address 192.168.1.88/24
    # address 192.168.1.87/24
    gateway 192.168.1.1
"
DNSOPTS="-d poove2-poo3s-worker-1.poos.home -n 192.168.1.1"
# DNSOPTS="-d poove2-poo3s-master-1.poos.home -n 192.168.1.1"
TIMEZONEOPTS="-z America/New_York"
PROXYOPTS="none"
APKREPOSOPTS="-r"
SSHDOPTS="-c openssh"
NTPOPTS="-c openntpd"
DISKOPTS="-m sys /dev/sda"
EOF

setup-alpine -f answers.txt

cat <<EOF > /etc/rc.local
#!/bin/sh -e

# Kubeadm 1.15 needs /dev/kmsg to be there, but it's not in lxc, but we can just use /dev/console instead
# see: https://github.com/kubernetes-sigs/kind/issues/662
if [ ! -e /dev/kmsg ]; then
    ln -s /dev/console /dev/kmsg
fi

# https://medium.com/@kvaps/run-kubernetes-in-lxc-container-f04aa94b6c9c
mount --make-rshared /
EOF

chmod +x /etc/rc.local
reboot
