# Add the helm repo
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Install nginx
kubectl create namespace monitoring
helm install grafana grafana/grafana -n monitoring -f values.yaml
