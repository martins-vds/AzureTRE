#!/bin/bash

set -o errexit
set -o pipefail

bastion_subscription_id=$1
bastion_resource_group=$2
bastion_name=$3
vm_id=$4

shareable_link_api_url="https://management.azure.com/subscriptions/$bastion_subscription_id/resourceGroups/$bastion_resource_group/providers/Microsoft.Network/bastionHosts/$bastion_name/createShareableLinks?api-version=2023-06-01"

get_access_token() {
  az account get-access-token --output json | jq -r .accessToken
}

create_shareable_link() {
  local access_token=$1
  local request_body=$2

  response=$(curl -isS -X POST -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -d "$request_body" "$shareable_link_api_url")
  status_code=$(echo "$response" | head -n 1 | cut -d$' ' -f2)

  if [[ "$status_code" -eq 202 ]]; then
    location=$(echo "$response" | grep -oP '[l|L]ocation: \K.*')
    wait_for_link_creation "$access_token" "$location"
  elif [[ "$status_code" -eq 200 ]]; then
    echo "$response" | tail -n 1
  else
    exit 1
  fi
}

wait_for_link_creation() {
  local access_token=$1
  local location=$2

  while true; do
    response=$(curl -isS -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" "$location")
    status_code=$(echo "$response" | head -n 1 | cut -d$' ' -f2)

    if [[ "$status_code" -eq 200 || "$status_code" -eq 202 ]]; then
      break
    elif [[ "$status_code" -eq 400 ]]; then
      exit 1
    fi
    sleep 5
  done

  echo "$response" | tail -n 1
}

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

access_token=$(get_access_token)
create_shareable_link "$access_token" "$request_body"
