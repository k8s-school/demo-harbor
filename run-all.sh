#!/bin/bash

# Install a harbor registry from scratch

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

$DIR/prereq.sh
$DIR/install_nginx.sh
$DIR/loadbalancer.sh
$DIR/argocd.sh
$DIR/install_harbor.sh