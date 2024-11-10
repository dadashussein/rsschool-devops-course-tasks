#!/bin/bash
curl -sfL https://get.k3s.io | sh -

mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(whoami):$(whoami) ~/.kube/config

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash