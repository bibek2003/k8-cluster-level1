#!/bin/bash

#Install metrics server
#git clone https://github.com/kubernetes-incubator/metrics-server.git
cd metric-server/1.8+/
kubectl create -f .
kubectl get pods -n kube-system
kubectl top nodes
kubectl top pods --all-namespaces
cd -
kubectl create -f hpa-cpu.yaml -n staging
kubectl create -f hpa-cpu.yaml -n production
apt-get install siege
