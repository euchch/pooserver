# Add the helm repo
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update

# Install metallb
kubectl create namespace nginx
helm install poonginx nginx-stable/nginx-ingress -n nginx --set controller.service.loadBalancerIP=192.168.1.254,rbac.create=true
