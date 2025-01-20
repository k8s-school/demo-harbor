#!/bin/bash

# Install a harbor registry from scratch

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

$DIR/prereq.sh
$DIR/argocd.sh
$DIR/wait-s3-bucket.sh
$DIR/loadbalancer.sh
$DIR/push-image.sh
