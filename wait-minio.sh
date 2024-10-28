#!/bin/bash

# Install and configure Harbor

# @author  Fabrice Jammes

set -euxo pipefail

timeout=240

while true
do
  ink "Wait for minio s3 endpoint to be ready"
  endpoints=$(kubectl get endpoints -l v1.min.io/tenant=minio -n minio -o jsonpath='{range .items[*]}{.subsets[*].addresses[*].ip}{'\n'}{end}')
  if [ "$endpoints" ]; then
    break
  fi
  sleep 5
done



