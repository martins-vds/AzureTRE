#!/bin/bash

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
    location=$(echo "$response" | grep -oP '[l|L]ocation: \K.*' | tr -d '\r\n')
    wait_for_link_creation "$access_token" "$location"
  elif [[ "$status_code" -eq 200 ]]; then
    echo "$response" | tail -n 1
  else
    echo "$response" | tail -n 1 | jq -r .error.message
    exit 1
  fi
}

wait_for_link_creation() {
  local access_token=$1
  local location=$2

  while true; do
    response=$(curl -isSG -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" "$location")
    status_code=$(echo "$response" | head -n 1 | cut -d$' ' -f2)
    retry_after_string=$(echo "$response" | grep -oP '[r|R]etry-[a|A]fter: \K.*')

    if [[ -n "$retry_after_string" ]]; then
      retry_after=$(echo "$retry_after_string" | tr -d '\r\n')
    else
      retry_after=""
    fi

    if [[ "$status_code" -eq 200 ]]; then
      echo "$response" | tail -n 1
      break
    elif [[ "$status_code" -eq 400 ]]; then
      echo "$response" | tail -n 1 | jq -r .error.message
      exit 1
    fi

    if [[ -n "$retry_after" ]]; then
      sleep "$retry_after"
    else
      sleep 5
    fi
  done
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
