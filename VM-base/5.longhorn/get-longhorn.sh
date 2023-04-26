# Add the helm repo
helm repo add longhorn https://charts.longhorn.io
helm repo update

# Install nginx
kubectl create namespace longhorn
kns longhorn
helm install poostorage longhorn/longhorn -n longhorn -f values.yaml
