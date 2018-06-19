#!/bin/bash
pushd /home/ahab/.scripts/targets/docker_socket/
echo "Setting up docker socket target..."
docker build . -t docker_sock_mount
popd
echo "Starting up docker target: docker_sock_mount..."
docker run -d -v /var/run/docker.sock:/var/run/docker.sock:ro --name this_better_work docker_sock_mount
echo "BLAH..."