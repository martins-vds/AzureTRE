#!/bin/bash

if [ -z "${nexus_proxy_url}" ]; then
  echo "nexus_proxy_url is not set. Skipping pypi sources config."
  exit 0
fi

sudo tee /etc/pip.conf > dev/null <<'EOF'
[global]
index = ${nexus_proxy_url}/repository/pypi/pypi
index-url = ${nexus_proxy_url}/repository/pypi/simple
trusted-host = ${nexus_proxy_url}
EOF
