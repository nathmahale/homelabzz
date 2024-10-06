#!/bin/bash

echo "Installing dependencies"

: ' architecture x86_64
clientVersion:
  buildDate: "2022-09-16T02:32:15Z"
  compiler: gc
  gitCommit: e4d4e1ab7cf1bf15273ef97303551b279f0920a9
  gitTreeState: clean
  goVersion: go1.19
  minor: "25"
  platform: linux/amd64
kustomizeVersion: v4.5.7
serverVersion:
  buildDate: "2022-05-24T12:18:48Z"
  compiler: gc
  gitCommit: 3ddd0f45aa91e2f30c70734b175631bec5b5825a
  gitTreeState: clean
  goVersion: go1.18.2
  minor: "24"
  platform: linux/amd64
'

### install packages
sudo apt install -y apache2-utils \
    curl \
    httpd-tools \
    telnet \
    python3 \
    python3-pip \
    figlet \
    toilet

### install helm
cd ~
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


### reboot system
# [ -f /var/run/reboot-required ] && sudo reboot -f

### minikube
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube
minikube version

### kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$kubectlVersion/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl