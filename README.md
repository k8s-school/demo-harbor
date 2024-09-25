# demo-harbor
Harbor demo

## Pre-requisites

- Linux (tested on Ubuntu 224.04)
- Sudo access
- Docker (24.0.6+)
- Go (1.22.5+)

## Run

```bash
# Install dependencies (kind, helm, ...)
./ignite.s

# Bootstrap Kubernetes cluster
./prereq.sh

# Install and configure nginx-controller
./install_nginx.sh

# Install and configure Harbor
# Display connection information
./install_harbor.sh
```


# Test (WIP)

```bash
# Simulate load-balancer
sudo $(which txeh) add 127.0.0.1 "$harbor_domain"
sudo socat tcp-listen:80,reuseaddr,fork tcp:172.18.0.2:32002
sudo socat tcp-listen:443,reuseaddr,fork tcp:172.18.0.2:32625


# TODO fix it  using values.yaml
kubectl edit -n harbor cm harbor-csan-registry
# add skipverify:
    #   s3:
    #     region: us-west-1
    #     bucket: harbor
    #     regionendpoint: https://minio.minio:443
    #     skipverify: true

# Restart pod
kubectl delete pod -n harbor harbor-csan-registry-6c945bcb45-ll8gj

# Create image
sudo apt install podman
# User: admin:, pass: Harbor12345
podman login --tls-verify=false core.harbor.domain/library
podman pull ubuntu:latest
podman tag ubuntu:latest core.harbor.domain/library/ubuntu:latest
podman push --tls-verify=false core.harbor.domain/library/ubuntu:latest
```