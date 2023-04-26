# Add the helm repo
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Install metallb
kubectl create namespace metallb
helm install pooslb bitnami/metallb -f values.yaml -n metallb