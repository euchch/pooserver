# Add the helm repo
helm repo add k8s-at-home https://k8s-at-home.com/charts/
helm repo update

# Install nginx
kubectl create namespace vaultwarden
kns vaultwarden
helm install pooltwarden k8s-at-home/vaultwarden -n vaultwarden -f values.yaml
