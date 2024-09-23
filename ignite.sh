#!/bin/bash

# Prepare the environment for e2e tests

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

ciux_version=v0.0.4-rc8
go install github.com/k8s-school/ciux@"$ciux_version"

ciux ignite -l e2e
