#!/usr/bin/env sh

#ansible-playbook reset.yml -i inventory/poos3s/hosts.ini -kK --ask-vault-pass
ansible-playbook reset.yml -i inventory/poos3s/hosts.ini -K
