#!/bin/bash

# Install and configure Harbor

# @author  Fabrice Jammes

helm repo add harbor https://helm.goharbor.io
helm fetch harbor/harbor --untar