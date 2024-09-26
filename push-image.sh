#!/bin/bash

# Push a container image to Harbor

# @author  Fabrice Jammes

set -euxo pipefail

sudo apt install podman
# User: admin:, pass: Harbor12345
podman login --tls-verify=false core.harbor.domain/library

# Create image
podman pull ubuntu:latest
podman tag ubuntu:latest core.harbor.domain/library/ubuntu:latest

# Push image
podman push --tls-verify=false core.harbor.domain/library/ubuntu:latest
