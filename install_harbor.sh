#!/bin/bash

# Install and configure Harbor

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

. $DIR/conf.sh

ink "Install Harbor"
helm repo add harbor https://helm.goharbor.io
helm upgrade --install harbor-csan harbor/harbor --version $harbor_chart_version -f $DIR/values.yaml

# Warn: might not always work because it assummes the https port is the second one
node_port=$(kubectl get svc ingress-nginx-controller -n "$ingress_ns"  -o jsonpath="{.spec.ports[1].nodePort}")

harbor_url="https://$harbor_domain:$node_port"
curl -k -L "$harbor_url"

ink "Login in to Harbor at URL $harbor_url with creds 'admin/Harbor12345'"
