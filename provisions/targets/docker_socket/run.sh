#!/bin/bash

pushd /vagrant/provisions/targets/docker_socket/
echo "Setting up docker socket target..."
docker build . -t docker_sock_mount
docker run -v /var/run/docker.sock:/var/run/docker.sock:ro --name mody_dick docker_sock_mount &