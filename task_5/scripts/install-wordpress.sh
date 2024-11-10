#!/bin/bash
curl -sfL https://get.k3s.io | sh -

mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(whoami):$(whoami) ~/.kube/config

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

kubectl get storageclass

helm repo add jenkins https://charts.jenkins.io
helm repo update

kubectl create namespace jenkins

helm install jenkins jenkins/jenkins --namespace jenkins
