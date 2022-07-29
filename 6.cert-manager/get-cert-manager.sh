CRTMGRVERSION=v1.9.1
# Add the helm repo
helm repo add jetstack https://charts.jetstack.io
helm repo update

# Setting up namespace
kubectl create namespace cert-manager
kns cert-manager

# Prereq: Install certManager CRDs (helm chart CAN do this but too many issues online complain it doesn't do it well)
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/${CRTMGRVERSION}/cert-manager.crds.yaml

# Install Certificate manager
helm install poos-cmgr jetstack/cert-manager --namespace cert-manager --create-namespace --version ${CRTMGRVERSION}

# Remove cert manager:
# helm uninstall poos-cmgr
# kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/${CRTMGRVERSION}/cert-manager.crds.yaml
