#!/bin/bash

set -e

stg_rg=$1
stg_account_name=$2
vmss_vnet=$3
vmss_subnet=$4

# Allow DevOps VMSS to access storage account

az storage account network-rule remove -g "$stg_rg" --account-name "$stg_account_name" --vnet-name "$vmss_vnet" --subnet "$vmss_subnet"
