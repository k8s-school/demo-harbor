#!/bin/bash

# Push a container image to Harbor

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

. $DIR/conf.sh

image="alpine:latest"

# Check if podman is installed
if ! command -v podman &> /dev/null
then
    echo "podman could not be found and will be installed"
    sudo apt install podman
fi

podman login --tls-verify=false \
    --username="$harbor_username" \
    --password="$harbor_password" \
    $harbor_domain/library

# Create image
podman pull "$image"
podman tag "$image" "$harbor_domain/library/$image"

# Push image
podman push --tls-verify=false "$harbor_domain/library/$image"
