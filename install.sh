#!/bin/bash

# Install and configure Harbor

# @author  Fabrice Jammes

chart_version=1.15.1

helm repo add harbor https://helm.goharbor.io

helm install harbor-csan harbor/harbor --version $chart_version -f values.yaml