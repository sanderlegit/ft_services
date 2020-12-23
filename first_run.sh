#!/bin/bash

# MetalLB configuration
kubectl apply -f ./srcs/MetalLB/namespace.yaml
kubectl apply -f ./srcs/MetalLB/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
