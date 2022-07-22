# Add the helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install nginx
kubectl create namespace monitoring
helm install poometheus prometheus-community/prometheus -n monitoring -f values.yaml
