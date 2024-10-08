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

# Synk operators dependency for harbor-registry
argocd app sync -l app.kubernetes.io/part-of=harbor-registry,app.kubernetes.io/component=operator
argocd app wait -l app.kubernetes.io/part-of=harbor-registry,app.kubernetes.io/component=operator

# Synk all app for harbor-registry
argocd app sync -l app.kubernetes.io/part-of=harbor-registry

