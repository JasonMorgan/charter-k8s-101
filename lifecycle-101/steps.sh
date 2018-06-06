#!/bin/bash

## Get credentials for our Cluster

pks get-credentials prod1

kubectl get nodes
kubectl cluster-info

## Configure the Cluster

kubectl apply -f ~/JasonMorgan/infra-cluster/namespaces

kubens planespotter

### Launch some watchers

watch kubectl get pods

watch kubectl get rs

### Finish configuring the cluster

kubectl apply -R -f ~/JasonMorgan/infra-cluster/

#### Checkout cluster

kubectl get svc

##### Browse to planespotter url

kubectl get deployment

kubectl rollout history deployment/planespotter-frontend

## Update Planespoter

### Build the image

docker build -t jasonmorgan/planespotter-frontend:2.0.0 ~/docker-images/planespotter-frontend/

docker images

### Publish the image

docker push jasonmorgan/planespotter-frontend:2.0.0

### Pull down the image

docker pull jasonmorgan/planespotter-frontend:2.0.0

### Tag the image for my local harbor repo

docker tag jasonmorgan/planespotter-frontend:2.0.0 harbor.gcp.59s.io/59s/planespotter-frontend:2.0.0

### Login

docker login harbor.gcp.59s.io/59s

### Push it up to harbor

docker push harbor.gcp.59s.io/59s/planespotter-frontend:2.0.0

#### Checkout the scan results https://harbor.gcp.59s.io

### Update the deployment manifest

vim ~/JasonMorgan/infra-cluster/Deployment/planespotter-frontend.yml

### Apply the updated deployment

kubectl apply -f ~/JasonMorgan/infra-cluster/Deployment/planespotter-frontend.yml

#### Watch the deployment

### Checkout the rollouts

kubectl rollout history deployment/planespotter-frontend

### Rollback

kubectl rollout undo deployment/planespotter-frontend

## Configure a new cluster

pks get-credentials prod2

kubectl get nodes
kubectl cluster-info

## Configure the Cluster

kubectl apply -f ~/JasonMorgan/infra-cluster/namespaces

kubens planespotter

### Finish configuring the cluster

kubectl apply -R -f ~/JasonMorgan/infra-cluster/

### Checkout planespotter

kubectl get svc

##### Browse to planespotter url
