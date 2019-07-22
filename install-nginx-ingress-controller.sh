#!/bin/bash

#Create the Nginx controller deployment using kubectl
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
kubectl get pods -n ingress-nginx

#Setup LoadBalancer Service For Ingress Controller
kubectl apply -f nginx-ingress.yaml
kubectl get svc -n ingress-nginx
