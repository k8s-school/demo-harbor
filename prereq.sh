#!/bin/bash

# Install pre-requisite for e2e tests

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

cluster_name=$(ciux get clustername $DIR)

ktbx install kind
ktbx install kubectl
ktbx install helm
ink "Create kind cluster"
ktbx create -s --name $cluster_name
ink "Install OLM"
ktbx install olm
ink "Install ArgoCD operator"
ktbx install argocd


