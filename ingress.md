```sh
### Install Ingress Controller.
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace

kubectl get po -n ingress-nginx
kubectl get svc -n ingress-nginx
kubectl get ing -n ingress-nginx
```