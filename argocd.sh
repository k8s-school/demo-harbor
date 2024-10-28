#!/bin/bash

# Install and configure Harbor

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

. $DIR/conf.sh

argocd login --core
kubectl config set-context --current --namespace="$argocd_ns"

argocd app create harbor-registry --dest-server https://kubernetes.default.svc \
    --dest-namespace "$argocd_ns" \
    --repo https://github.com/k8s-school/demo-harbor.git \
    --path cd

argocd app sync harbor-registry

ink "Synk operator dependencies for harbor-registry"
argocd app sync -l app.kubernetes.io/part-of=harbor-registry,app.kubernetes.io/component=operator
argocd app wait -l app.kubernetes.io/part-of=harbor-registry,app.kubernetes.io/component=operator

ink "Synk all apps for harbor-registry"
argocd app sync -l app.kubernetes.io/part-of=harbor-registry

while true
do
  ink "Wait for minio s3 endpoint to be ready"
  endpoints=$(kubectl get endpoints minio -n minio -o jsonpath='{.subsets[*].addresses[*].ip}')
  if [ "$endpoints" ]; then
    break
  fi
  sleep 5
done

