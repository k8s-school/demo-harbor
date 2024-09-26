#!/bin/bash

# Push a container image to Harbor

# @author  Fabrice Jammes

set -euxo pipefail

image="alpine:latest"

sudo apt install podman
# User: admin:, pass: Harbor12345
podman login --tls-verify=false core.harbor.domain/library

# Create image
podman pull "$image"
podman tag "$image" "core.harbor.domain/library/$image"

# Push image
podman push --tls-verify=false "core.harbor.domain/library/$image"
