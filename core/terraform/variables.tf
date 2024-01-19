variable "tre_id" {
  type        = string
  description = "Unique identifier for the TRE, such as projectx-dev-1234"
  validation {
    condition     = length(var.tre_id) < 12 && lower(var.tre_id) == var.tre_id
    error_message = "The tre_id value must be lowercase and < 12 chars."
  }
}

variable "location" {
  type        = string
  description = "Azure region for deployment of core TRE services"
}

variable "acr_name" {
  type        = string
  description = "Management ACR name"
}

variable "core_address_space" {
  type        = string
  description = "Core services VNET Address Space"
  validation {
    condition     = parseint(element(split("/", var.core_address_space), 1), 10) > 0 && parseint(element(split("/", var.core_address_space), 1), 10) <= 22
    error_message = "core_address_space size should be /22 or larger"
  }
}

variable "tre_address_space" {
  type        = string
  description = "Overall TRE Address Space pool, will be used for workspace VNETs, can be a supernet of address_space."
}

variable "api_image_repository" {
  type        = string
  description = "Repository for API image"
  default     = "microsoft/azuretre/api"
}

variable "core_app_service_plan_sku" {
  type    = string
  default = "P1v3"
}

variable "resource_processor_vmss_porter_image_repository" {
  type        = string
  description = "Repository for resource processor vmms porter image"
  default     = "microsoft/azuretre/resource-processor-vm-porter"
}

variable "mgmt_storage_account_name" {
  type        = string
  description = "Storage account created by bootstrap to hold all Terraform state"
}

variable "mgmt_resource_group_name" {
  type        = string
  description = "Shared management resource group"
}

variable "terraform_state_container_name" {
  type        = string
  description = "Name of the storage container for Terraform state"
}

variable "resource_processor_number_processes_per_instance" {
  type        = number
  default     = 5
  description = "The number of CPU processes to run the RP on per VM instance"
}

variable "enable_swagger" {
  type        = bool
  default     = false
  description = "Determines whether the Swagger interface for the API will be available."
  sensitive   = false
}

variable "enable_bastion" {
  type        = bool
  default     = false
  description = "Determines whether the bastion host will be deployed."
  sensitive   = false
}

variable "swagger_ui_client_id" {
  type        = string
  description = "The client id (app id) of the registration in Azure AD for the Swagger UI"
  sensitive   = true
}

variable "aad_tenant_id" {
  type        = string
  description = "The tenant id of the Azure AD used for authentication."
  sensitive   = true
}

variable "api_client_id" {
  type        = string
  description = "The client id (app id) of the registration in Azure AD for the API."
  sensitive   = true
}

variable "api_client_secret" {
  type        = string
  description = "A client secret used by the API to authenticate with Azure AD for access to Microsoft Graph."
  sensitive   = true
}

variable "application_admin_client_id" {
  type        = string
  description = "The client id (app id) of the registration in Azure AD for creating AAD Applications."
  sensitive   = true
}

variable "application_admin_client_secret" {
  type        = string
  description = "A client secret used by the Resource Processor to authenticate with Azure AD to create AAD Applications."
  sensitive   = true
}

variable "resource_processor_type" {
  default     = "vmss_porter"
  description = "Which resource processor to deploy."
  type        = string
}

variable "resource_processor_vmss_sku" {
  type        = string
  default     = "Standard_B2s"
  description = "The SKU of the resource processor VMSS."
}

variable "arm_environment" {
  type        = string
  default     = "public"
  description = "Used as an environment variable in the VMSS to set the Azure cloud for Terraform"
}

variable "arm_use_msi" {
  type        = bool
  default     = false
  description = "Used as an environment variable to determine if Terraform should use a managed identity"
}


variable "stateful_resources_locked" {
  type        = bool
  default     = true
  description = "Used to add locks on resources with state"
}

variable "ci_git_ref" {
  default     = ""
  description = "The git ref used by the ci to deploy this TRE"
  type        = string
}

variable "enable_local_debugging" {
  default     = false
  description = "This will allow Cosmos to be accessible from your local IP address and add some extra role permissions."
  type        = bool
}

# this var is optional and used to avoid assigning a role on every run.
variable "arm_subscription_id" {
  description = "The subscription id to create the resource processor permission/role. If not supplied will use the TF context."
  type        = string
  default     = ""
}

variable "public_deployment_ip_address" {
  description = "Your local IP address if https://ipecho.net/plain is blocked."
  type        = string
  default     = ""
}

variable "enable_airlock_malware_scanning" {
  type        = bool
  default     = false
  description = "If False, Airlock requests will skip the malware scanning stage"
}

variable "rp_bundle_values" {
  description = "Additional environment values to set on the resource processor that can be supplied to template bundles"
  type        = map(string)
  default     = {}
}

variable "is_cosmos_defined_throughput" {
  type    = bool
  default = false
}

variable "logging_level" {
  type        = string
  default     = "INFO"
  description = "The logging level for the API and Resource Processor"
  validation {
    condition     = contains(["INFO", "DEBUG", "WARNING", "ERROR"], var.logging_level)
    error_message = "logging_level must be one of ERROR, WARNING, INFO, DEBUG"
  }
}

variable "core_storage_allowed_subnet_ids" {
  type        = list(string)
  default     = []
  description = "Network rule set for storage account"
}

variable "core_keyvault_allowed_subnet_ids" {
  type        = list(string)
  default     = []
  description = "Network rule set for keyvault"
}

variable "core_static_web_allowed_subnet_ids" {
  type        = list(string)
  default     = []
  description = "Network rule set for static web"
}

variable "core_api_allowed_subnet_ids" {
  type        = list(string)
  default     = []
  description = "Network rule set for app gateway"
}

variable "deploy_app_gateway" {
  type        = bool
  default     = true
  description = "Deploy app gateway"
}

variable "use_existing_private_dns_zone" {
  type        = bool
  default     = false
  description = "Use existing private DNS zone for ACR"
}

variable "private_dns_zone_resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group of private DNS zone for ACR"
}

variable "private_dns_zone_azure_credentials"{
  type        = string
  default     = "secondary"
  description = "Azure credentials for private DNS zone for ACR"

  validation {
    condition = contains(["primary", "secondary"], var.private_dns_zone_azure_credentials)
    error_message = "private_dns_zone_azure_credentials must be either primary or secondary"
  }
}

variable "secondary_arm_tenant_id" {
  type        = string
  default     = ""
  description = "Secondary ARM tenant ID"
}

variable "secondary_arm_subscription_id" {
  type        = string
  default     = ""
  description = "Secondary ARM subscription ID"
}

variable "secondary_arm_client_id" {
  type        = string
  default     = ""
  description = "Secondary ARM client ID"
}

variable "secondary_arm_client_secret" {
  type        = string
  default     = ""
  description = "Secondary ARM client secret"
  sensitive = true
}
