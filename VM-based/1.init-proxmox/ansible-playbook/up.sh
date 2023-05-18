#!/usr/bin/env sh

ansible-playbook site.yml -i inventory/poos.home/hosts.yml -K
