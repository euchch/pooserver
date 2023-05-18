#!/usr/bin/env sh

ansible-playbook reboot.yml -i inventory/poos3s/hosts.ini -K
