#!/bin/bash

# Install and configure Harbor

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

. $DIR/conf.sh

namespace="argocd"

argocd login --core
kubectl config set-context --current --namespace="$namespace"


argocd app create harbor-registry --dest-server https://kubernetes.default.svc \
    --dest-namespace "$namespace" \
    --repo https://github.com/k8s-school/demo-harbor.git \
    --path cd

argocd app sync harbor-registry
