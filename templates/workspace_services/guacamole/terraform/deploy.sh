#!/bin/bash
set -e

export TF_LOG=""
# This script assumes you have created an .env from the sample and the variables
# will come from there.
# shellcheck disable=SC2154
terraform init -upgrade -input=false -backend=true -reconfigure \
    -backend-config="resource_group_name=$TF_VAR_mgmt_resource_group_name" \
    -backend-config="storage_account_name=$TF_VAR_mgmt_storage_account_name" \
    -backend-config="container_name=$TF_VAR_terraform_state_container_name" \
    -backend-config="key=${TRE_ID}${TF_VAR_workspace_id}guacamole"
terraform plan
terraform apply -auto-approve
