#!/bin/bash

set -x
set -o errexit
set -o pipefail

bastion_subscription_id=$1
bastion_resource_group=$2
bastion_name=$3
vm_id=$4

shareable_link_api_url="https://management.azure.com/subscriptions/$bastion_subscription_id/resourceGroups/$bastion_resource_group/providers/Microsoft.Network/bastionHosts/$bastion_name/createShareableLinks?api-version=2023-06-01"

request_body="$(cat <<EOF
{
  "vms": [
    {
      "vm": {
        "id": "$vm_id"
      }
    }
  ]
}
EOF
)"

get_access_token() {
  az account get-access-token --output json | jq -r .accessToken
}

echo "Getting access token"
access_token=$(get_access_token)
echo "Creating shareable link"
response=$(curl -si -X POST -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -d "$request_body" "$shareable_link_api_url")
status_code=$(echo "$response" | head -n 1 | cut -d$' ' -f2)
if [[ "$status_code" -eq 202 ]]; then
  location=$(echo "$response" | grep -oP '[l|L]ocation: \K.*')
  # Wait for the link to be created in a loop
  while true; do
    response=$(curl -si -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" "$location")
    status_code=$(echo "$response" | head -n 1 | cut -d$' ' -f2)
    echo "Status code: $status_code"
    if [[ "$response" == "" ]]; then
      echo "Failed to check the status of the link creation"
      exit 1
    fi
    status_code=$(echo "$response" | head -n 1 | cut -d$' ' -f2)
    if [[ "$status_code" -eq 200 || "$status_code" -eq 202 ]]; then
      echo "$response" | jq -r .value[0].bsl
    elif [[ "$status_code" -eq 404 ]]; then
      echo "$response" | jq -r .error.message
    fi
    sleep 5
  done

  # Get the link
  echo "$response" | jq -r .value[0].bsl
elif [[ "$status_code" -eq 200 ]]; then
  echo "$response" | jq -r .value[0].bsl
else
  echo "Failed to create the shareable link"
  exit 1
fi
