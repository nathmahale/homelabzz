#!/bin/bash

control_plane_node="N"

install_docker() {
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo apt-add-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

    sudo apt-get update
    sudo apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu
    sudo apt-mark hold docker-ce
    sudo usermod -aG docker $USER
}

install_k8s_tools() {
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
    sudo apt-get update

    sudo apt-get install -y kubernetes-cni=0.6.0-00 kubelet=1.12.2-00 kubeadm=1.12.2-00 kubectl=1.12.2-00
    sudo apt-mark hold kubelet kubeadm kubectl

    ## check kubeadm
    kubeadm version
}

init_kubeadm() {
    sudo kubeadm init --pod-network-cidr=10.244.0.0/16
}

init_kubeconfig() {
    mkdir -p ${HOME}/.kube
    sudo cp -i /etc/kubernetes/admin.conf ${HOME}/.kube/config
    sudo chown $(id -u):$(id -g) ${HOME}/.kube/config
}

init_networking() {
    echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
}

install_flannel() {
    kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel-old.yaml
}

common_setup() {
    install_docker
    install_k8s_tools
}

init_control_plane() {
    init_kubeadm
    init_networking
    install_flannel
    init_kubeconfig
}

containerd_install() {
    cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
    sudo modprobe overlay
    sudo modprobe br_netfilter

    cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
    sudo sysctl --system
    sudo apt-get update
    sudo apt-get install -y containerd

    sudo mkdir -p /etc/containerd
    sudo containerd default | sudo tee /etc/containerd/config.toml
    sudo systemctl restart containerd
    sudo swapoff -a
    sudo apt-get install -y apt-transport-https curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
    sudo apt-get update
    sudo apt-get install -y kubernetes-cni=0.6.0-00 kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00
    sudo apt-mark hold kubelet kubeadm kubectl

}
