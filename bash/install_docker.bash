#!/bin/bash

apt-get install ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

os_arch=$(dpkg --print-architecture)

echo \
  "deb [arch=${os_arch} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  \"$(. /etc/os-release && echo "$VERSION_CODENAME")\" stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

install_cert_manager() {
  helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.13.0 --set installCRDs=true
}
