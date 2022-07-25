# Add the helm repo
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update

# Install nginx
kubectl create namespace nginx
kns nginx
helm install poonginx nginx-stable/nginx-ingress -n nginx -f values.yaml
