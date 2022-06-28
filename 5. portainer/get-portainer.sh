# Add the helm repo
helm repo add portainer https://portainer.github.io/k8s/
helm repo update

# Install metallb
kubectl create namespace portainer
helm install -n portainer portainer portainer/portainer --set service.type=ClusterIP
