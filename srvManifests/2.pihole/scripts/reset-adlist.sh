#!/bin/bash

SERVER=$1

if [ -z "$(kubectl get pods --field-selector metadata.name=$SERVER)" ]; then  
    echo "$SERVER pod does not exist!!!"
    exit
fi

ADLIST_FILE=./adlists.list
SOURCE=`dirname ${BASH_SOURCE[0]}`
echo "switching to $SOURCE"
pushd $SOURCE

if [ ! -f "$ADLIST_FILE" ]; then
    echo "$ADLIST_FILE is missing."
    popd
    exit
fi

kubectl exec $SERVER -- sudo sqlite3 /etc/pihole/gravity.db "DELETE FROM adlist"
kubectl exec $SERVER -- sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts', 1, 'default')"

while IFS= read -r line || [[ "$line" ]]; do
    IFS=',' read -ra my_rec <<< "$line"   # str is read into an array as tokens separated by IFS
    echo "enabled: ${my_rec[0]}, desc: ${my_rec[1]}, url: ${my_rec[2]}"
    kubectl exec $SERVER -- sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('${my_rec[2]}', ${my_rec[0]}, '${my_rec[1]}')"
done < $ADLIST_FILE

kubectl exec $SERVER -- pihole -g

popd