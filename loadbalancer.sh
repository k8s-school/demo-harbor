#!/bin/bash

# Simulate load-balancer in front of k8s ingress controller

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

. $DIR/conf.sh

# Warn: might not always work because it assummes the https port is the second one
http_node_port=$(kubectl get svc ingress-nginx-controller -n "$ingress_ns"  -o jsonpath="{.spec.ports[0].nodePort}")
https_node_port=$(kubectl get svc ingress-nginx-controller -n "$ingress_ns"  -o jsonpath="{.spec.ports[1].nodePort}")

# Get master node IP
node_ip=$(kubectl get nodes -o=jsonpath='{.items[0].status.addresses[0].address}')

sudo socat tcp-listen:80,reuseaddr,fork tcp:$node_ip:$http_node_port &
sudo socat tcp-listen:443,reuseaddr,fork tcp:$node_ip:$https_node_port &

# Configure DNS
sudo $(which txeh) remove host "$harbor_domain"
sudo $(which txeh) add 127.0.0.1 "$harbor_domain"