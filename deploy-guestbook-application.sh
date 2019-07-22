#!/bin/bash

#Clone the guestbook git repository
git clone https://github.com/kubernetes/examples.git
cd examples/guestbook
kubectl create namespace staging
kubectl create namespace production
kubectl get namespaces

#Creating the Redis Master Deployment
#------------------------------------
kubectl apply -f redis-master-deployment.yaml --namespace=staging
kubectl get pods --namespace=staging
kubectl logs -f redis-master-57fc67768d-g66cx --namespace=staging

kubectl apply -f redis-master-deployment.yaml --namespace=production
kubectl get pods --namespace=production
kubectl logs -f redis-master-57fc67768d-g66cx --namespace=production

#Creating the Redis Master Service
#---------------------------------

kubectl apply -f redis-master-service.yaml --namespace=staging
kubectl get service --namespace=staging

kubectl apply -f redis-master-service.yaml --namespace=production
kubectl get service --namespace=production

#Creating the Redis Slave Deployment
#-----------------------------------

kubectl apply -f redis-slave-deployment.yaml --namespace=staging
kubectl get pods --namespace=staging

kubectl apply -f redis-slave-deployment.yaml --namespace=production
kubectl get pods --namespace=production


#Creating the Redis Slave Service
#--------------------------------

kubectl apply -f redis-slave-service.yaml --namespace=staging
kubectl get service --namespace=staging

kubectl apply -f redis-slave-service.yaml --namespace=production
kubectl get service --namespace=production


#Creating the Guestbook Frontend Deployment
#------------------------------------------

kubectl apply -f frontend-deployment.yaml --namespace=staging
kubectl get pods -l app=guestbook -l tier=frontend --namespace=staging

kubectl apply -f frontend-deployment.yaml --namespace=production
kubectl get pods -l app=guestbook -l tier=frontend --namespace=production

#Creating the Frontend Service
#-----------------------------

kubectl apply -f frontend-service.yaml --namespace=staging
kubectl get services --namespace=staging
kubectl get service frontend --namespace=staging

kubectl apply -f frontend-service.yaml --namespace=production
kubectl get services --namespace=production
kubectl get service frontend --namespace=production

