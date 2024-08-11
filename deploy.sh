kind create cluster --name k8s-playground --config kind-config.yaml

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# If using kind do
# kubectl edit deploy metrics-server -n kube-system
# and set the arg --kubelet-insecure-tls on the metrics server container

kubectl apply -f ./manifests/scaling/HPAs.yaml
kubectl apply -f ./manifests/


