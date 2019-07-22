#!/bin/bash

#Add host entries
echo `kubectl get svc -n staging -o wide|grep frontend |awk '{ print $3" staging-guestbook.mstakx.io staging-guestbook" }'` >> /etc/hosts
echo `kubectl get svc -n production -o wide|grep frontend |awk '{ print $3" guestbook.mstakx.io guestbook" }'` >> /etc/hosts

#Create Nginx Ingress Object
kubectl create -f staging-k8-ingress-resource.yaml
kubectl create -f production-k8-ingress-resource.yaml
