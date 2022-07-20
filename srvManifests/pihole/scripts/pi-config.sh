#!/bin/bash

PHQUERY='{.items[?(@.metadata.labels.app=="pihole")].metadata.name}'
NS=pihole
phServers=$(kubectl get pods -o=jsonpath="${PHQUERY}")
echo "hosts list: ${phServers}"

while IFS= ${phServers} || [[ "$server" ]]; do
done