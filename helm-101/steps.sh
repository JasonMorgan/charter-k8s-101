#!/bin/bash

## Move into our temp directory
cd ~/temp

## Grab cluster creds for kubectl

pks get-credentials infra

## Let's prep our RBAC enabled cluster for helm

kubectl apply -f ~/JasonMorgan/basic-cluster/ServiceAccount/tiller.yml
kubectl apply -f ~/JasonMorgan/basic-cluster/ClusterRoleBinding/tiller-clusterrolebinding.yml

### This is just an implementation detail, you can use any namespace you want

kubectl apply -f ~/JasonMorgan/basic-cluster/Namespace/tools.yml

## Get helm going

helm init --service-account tiller
helm version

### This is just an implementation detail, you can use any namespace you want

kubens tools

## Find an app

helm search concourse

### Let's checkout the packages a bit more

helm search concourse -l 

## Install concourse

helm install -n prod-concourse --version 1.0.5 stable/concourse
helm list

### In another window

watch kubectl get pods

### In another another window

export POD_NAME=$(kubectl get pods --namespace tools -l "app=prod-concourse-web" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward --namespace tools $POD_NAME 8080:8080

#### Set a pipeline
fly -t local login -c http://localhost:8080
fly -t local set-pipeline -p configure-k8s-cluster -c pipeline.yml -n

#### Go check it out http://localhost:8080

## Back to work, let's upgrade!

helm list
helm upgrade prod-concourse stable/concourse
helm list

### Now rollback

helm rollback prod-concourse 1
helm list

#### Go check it out http://localhost:8080

#### Break 

## And another upgrade, but this time let's update the container version

helm inspect values stable/concourse | more

helm upgrade --set imageTag=3.10.0 prod-concourse stable/concourse

### In another another window, once the pods are ready

export POD_NAME=$(kubectl get pods --namespace kube-system -l "app=prod-concourse-web" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward --namespace kube-system $POD_NAME 8080:8080

### Let's scale out our workers

helm inspect values stable/concourse | more

helm upgrade --set imageTag=3.10.0 --set worker.replicas=5 prod-concourse stable/concourse --wait

helm list

helm rollback prod-concourse "last revision"

helm list

helm rollback prod-concourse "last revision"

## helm inspec

helm inspect chart stable/concourse
helm inspect values stable/concourse
helm inspect readme stable/concourse