#!/bin/bash

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

az rest --method post --uri "$shareable_link_api_url" --body "$request_body" --output json
