#!/bin/bash

# set up DNS and the dashboard
microk8s.enable dns dashboard
# spin up the containerized nginx target
echo $(pwd)
microk8s.kubectl apply -f /vagrant/provisions/targets/kube_app/deployment.yaml