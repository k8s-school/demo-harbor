#!/bin/bash

# Install and configure Harbor

# @author  Fabrice Jammes

set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

. $DIR/conf.sh

namespace="harbor"


# NOTE: This command will retrieve the chart locally and may help while troubleshooting:
# helm fetch harbor/harbor --untar --version 1.15.1

ink "Install Harbor"
helm repo add harbor https://helm.goharbor.io
helm upgrade --wait --install harbor-csan harbor/harbor --version $harbor_chart_version -n "$namespace" --create-namespace -f $DIR/values.yaml

