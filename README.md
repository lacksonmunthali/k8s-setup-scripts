# Kubernetes Setup Scripts

This repository provides scripts to automate the setup of a Kubernetes cluster on Ubuntu 24.04 systems. The scripts help you configure both control plane and worker nodes with best practices for networking and container runtime.

## Supported OS
- **Ubuntu 24.04 LTS**

## Scripts

### 1. `k8s-node-setup.sh`
Prepares a node (control plane or worker) for Kubernetes installation by:
- Disabling swap
- Loading required kernel modules
- Setting sysctl parameters for networking
- Installing and configuring containerd as the container runtime
- Adding the Kubernetes apt repository and installing `kubeadm`, `kubelet`, and `kubectl`

**Usage:**
```sh
bash k8s-node-setup.sh
```

### 2. `k8s-controlplane-init.sh`
Initializes the Kubernetes control plane after running the node setup script. It:
- Runs `kubeadm init` with Flannel-compatible pod CIDR
- Sets up `kubectl` for the current user
- Deploys the Flannel CNI network

**Usage:**
```sh
bash k8s-controlplane-init.sh
```

## Cluster Join
After initializing the control plane, get the join command for worker nodes:
```sh
kubeadm token create --print-join-command
```
Run this command on each worker node after running `k8s-node-setup.sh`.

## Notes
- These scripts are intended for fresh Ubuntu 24.04 installations.
- Run all scripts as a user with `sudo` privileges.
- For multi-node clusters, run `k8s-node-setup.sh` on all nodes, and `k8s-controlplane-init.sh` only on the control plane node.

## Verification
Check cluster status with:
```sh
kubectl get nodes
```

---

**Author:** Lackson Munthali

## License

This project is licensed under the [MIT License](LICENSE).

---

GitHub: [https://github.com/lacksonmunthali/k8s-setup-scripts](https://github.com/lacksonmunthali/k8s-setup-scripts)
