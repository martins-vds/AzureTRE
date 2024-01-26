#!/bin/bash

set -o pipefail

use_builtin_bastion=$1
tre_id=$2

if [[ "$use_builtin_bastion" == "true" ]]; then
  bastion_subscription_id=$(az account show --query id --output tsv)
  bastion_resource_group="rg-${tre_id}"
  bastion_name="bas-${tre_id}"
else
  bastion_subscription_id=$3
  bastion_resource_group=$4
  bastion_name=$5
fi

az account set --subscription "$bastion_subscription_id" --only-show-errors > /dev/null 2>&1
az extension add --name bastion --upgrade --yes --only-show-errors > /dev/null 2>&1
az network bastion show --name "$bastion_name" --resource-group "$bastion_resource_group" --query "{id:id, resourceGroup:resourceGroup, name:name}" --output json --only-show-errors
