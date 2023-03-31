# $ git clone https://github.com/coder/code-server
# $ cd code-server
# helm upgrade --install code-server ci/helm-chart

# Add the helm repo
helm repo add xide-server https://github.com/coder/code-server
helm repo update
helm install --install code-server ci/helm-chart -n code-server -f values.yaml

# Install CODE-SERVER
kubectl create namespace code-server
kns code-server
helm install poo-code-server code-server/vaultwarden -n vaultwarden -f values.yaml
