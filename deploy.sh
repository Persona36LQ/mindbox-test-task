kind create cluster --name k8s-playground --config kind-config.yaml

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# If using kind do
# kubectl edit deploy metrics-server -n kube-system
# and set the arg --kubelet-insecure-tls on the metrics server container

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update istio

kubectl create namespace istio-system

helm install istio istio/base --namespace istio-system --wait
helm install istiod istio/istiod -n istio-system --wait
helm install istio-ingress istio/gateway -n istio-system --wait

kubectl label namespace default istio-injection=enabled
kubectl apply -f ./manifests/istio/
kubectl apply -f ./manifests/scaling/HPAs.yaml
kubectl apply -f ./manifests/


