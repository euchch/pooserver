#!/bin/bash

PHQUERY='{.items[?(@.metadata.labels.app=="pihole")].metadata.name}'
NS=pihole
phServers=$(kubectl get pods -o=jsonpath="${PHQUERY}")
INITCMD="/bootstrap/init.sh"

for server in ${phServers}; do
    echo "Running $INITCMD on pod $server"
    kubectl exec $server -- $INITCMD
done