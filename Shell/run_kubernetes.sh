#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# dockerpath=<>
dockerpath=docker.io/deitryn/sb_capstone:latest
appname=capstone

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run $appname --image=$dockerpath --port=8080

# Step 3:
# Wait 10 Seconds for Pod to be Ready, Or Give Up
i=0
while [[ $(kubectl get pods $appname -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]] && [[ $i != 10 ]]; 
do 
	echo "Waiting for $appname pod to be ready" && sleep 1;
	let "i++";
done

# List Kubernetes Pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward $appname 8080:80