# Add the helm repo
helm repo add metallb https://metallb.github.io/metallb
helm repo update

# Install metallb
kubectl create namespace metallb
helm install metallb metallb/metallb -f values.yaml -n metallb