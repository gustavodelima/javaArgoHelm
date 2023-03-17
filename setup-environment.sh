#!/bin/bash


# Installing minikube
sudo apt-get update && sudo apt-get install -y curl virtualbox
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod +x /usr/local/bin/minikube

# Installing kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Installing Helm
sudo snap install helm --classic

# Installing argo-cd
helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd

kubectl port-forward svc/argocd-server -n default 8080:443
kubectl -n default get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d


