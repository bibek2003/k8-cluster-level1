#!/bin/bash

#Initialize the cluster on the Master node
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 |tee /tmp/k8-bootstrap-log.txt
cat /tmp/k8-bootstrap-log.txt|grep "kubeadm join" >> /tmp/join-worker-to-cluster.sh

#Install Flannel in the cluster by running this only on the Master node:
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml
