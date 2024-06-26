#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

# Baseline Azure resources
echo -e "\n\e[34m»»» 🤖 \e[96mCreating resource group and storage account\e[0m..."
# shellcheck disable=SC2154
az group create --resource-group "$TF_VAR_mgmt_resource_group_name" --location "$LOCATION" -o table

# shellcheck disable=SC2154
stg_name_available=$(az storage account check-name --name "$TF_VAR_mgmt_storage_account_name" --query nameAvailable -o tsv)

if [ "$stg_name_available" == "true" ]; then
  # shellcheck disable=SC2154
  az storage account create --resource-group "$TF_VAR_mgmt_resource_group_name" \
  --name "$TF_VAR_mgmt_storage_account_name" --location "$LOCATION" \
  --allow-blob-public-access false \
  --kind StorageV2 --sku Standard_LRS -o table \
  --public-network-access Enabled \
  --default-action Deny \
  --subnet "$BOOTSTRAP_STORAGE_ALLOWED_SUBNET_IDS"
fi

# Blob container
# shellcheck disable=SC2154
az storage container create --account-name "$TF_VAR_mgmt_storage_account_name" --name "$TF_VAR_terraform_state_container_name" --auth-mode login -o table

# logs container
az storage container create --account-name "$TF_VAR_mgmt_storage_account_name" --name "tflogs" --auth-mode login -o table

cat > bootstrap_backend.tf <<BOOTSTRAP_BACKEND
terraform {
  backend "azurerm" {
    resource_group_name  = "$TF_VAR_mgmt_resource_group_name"
    storage_account_name = "$TF_VAR_mgmt_storage_account_name"
    container_name       = "$TF_VAR_terraform_state_container_name"
    key                  = "bootstrap.tfstate"
  }
}
BOOTSTRAP_BACKEND

# Set up Terraform
echo -e "\n\e[34m»»» ✨ \e[96mterraform init -upgrade\e[0m..."
terraform init -upgrade -input=false -backend=true -reconfigure

# Import the storage account & res group into state
echo -e "\n\e[34m»»» 📤 \e[96mImporting resources to state\e[0m..."
if ! terraform state show azurerm_resource_group.mgmt 2> /dev/null; then
  echo  "/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/$TF_VAR_mgmt_resource_group_name"
  terraform import azurerm_resource_group.mgmt "/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/$TF_VAR_mgmt_resource_group_name"
fi

if terraform state show azurerm_storage_account.state_storage 2> /dev/null; then
  terraform state rm azurerm_storage_account.state_storage
fi

terraform import azurerm_storage_account.state_storage "/subscriptions/$ARM_SUBSCRIPTION_ID/resourceGroups/$TF_VAR_mgmt_resource_group_name/providers/Microsoft.Storage/storageAccounts/$TF_VAR_mgmt_storage_account_name"

echo "State updated successfully!"

set +o nounset
