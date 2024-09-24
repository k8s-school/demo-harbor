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
