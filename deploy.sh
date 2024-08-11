kind create cluster --name k8s-playground --config kind-config.yaml

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# If using kind do
# kubectl edit deploy metrics-server -n kube-system
# and set the arg --kubelet-insecure-tls on the metrics server container

kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/vpa-release-1.0/vertical-pod-autoscaler/deploy/vpa-v1-crd-gen.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/vpa-release-1.0/vertical-pod-autoscaler/deploy/vpa-rbac.yaml

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update istio

kubectl create namespace istio-system

helm install istio istio/base --namespace istio-system --wait
helm install istiod istio/istiod -n istio-system --wait
helm install istio-ingress istio/gateway -n istio-system --wait

helm install --namespace istio-system --set auth.strategy="anonymous" --repo https://kiali.org/helm-charts kiali-server kiali-server

kubectl label namespace default istio-injection=enabled
kubectl apply -f ./manifests/istio/
kubectl apply -f ./manifests/security/
kubectl apply -f ./manifests/scaling
kubectl apply -f ./manifests/