#!/bin/bash

set -e

stg_rg=$1
stg_account_name=$2
vmss_rg=$3
vmss_vnet=$4
vmss_subnet=$5

# Allow DevOps VMSS to access storage account

stg_exists=$(az storage account check-name --name "$stg_account_name" --query nameAvailable -o tsv)

if [ "$stg_exists" == "true" ]; then
    echo "Storage account $stg_account_name does not exist"
    exit 0
fi

az network vnet subnet update -g "$vmss_rg" --vnet-name "$vmss_vnet" --name "$vmss_subnet" --service-endpoints "Microsoft.Storage.Global"

vmss_subnet_id=$(az network vnet subnet show -g "$vmss_rg" --vnet-name "$vmss_vnet" --name "$vmss_subnet" --query id -o tsv)

az storage account network-rule add -g "$stg_rg" --account-name "$stg_account_name" --subnet "$vmss_subnet_id"
az storage account update -g "$stg_rg" --name "$stg_account_name" --default-action Deny --public-network-access Enabled
