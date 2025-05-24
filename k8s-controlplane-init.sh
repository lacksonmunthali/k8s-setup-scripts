#!/bin/bash
set -e

POD_CIDR="10.244.0.0/16"

echo "Initializing Kubernetes control plane..."
sudo kubeadm init --pod-network-cidr=$POD_CIDR

echo "Setting up kubectl for current user..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Deploying Flannel CNI network..."
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo "Control plane setup complete."
echo ""
echo "Run 'kubeadm token create --print-join-command' to get join command for worker nodes."
echo "You can now start adding worker nodes to the cluster."
echo "To check the status of the cluster, run 'kubectl get nodes'."