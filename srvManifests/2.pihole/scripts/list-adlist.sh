#!/bin/bash

SERVER=$1

if [ -z "$(kubectl get pods --field-selector metadata.name=$SERVER)" ]; then  
    echo "$SERVER pod does not exist!!!"
    exit
fi

SOURCE=`dirname ${BASH_SOURCE[0]}`
echo "switching to $SOURCE"
pushd $SOURCE

kubectl exec $SERVER -- sudo sqlite3 /etc/pihole/gravity.db "SELECT address, enabled, comment FROM adlist"

popd