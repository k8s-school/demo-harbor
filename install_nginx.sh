#!/bin/bash

# Install and configure nginx ingress controller

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

. $DIR/conf.sh

ink "Install nginx ingress controller"
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace "$ingress_ns" --create-namespace \
  --set controller.service.type=NodePort \
  --set controller.setAsDefaultIngress=true \
  --version $nginx_chart_version

ink "Wait for ingress-nginx controller to be available"
kubectl wait --for=condition=available deployment -n "$ingress_ns" -l app.kubernetes.io/instance=ingress-nginx
