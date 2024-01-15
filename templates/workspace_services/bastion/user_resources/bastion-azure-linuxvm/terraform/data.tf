data "azurerm_log_analytics_workspace" "oms-workspace" {
  name = local.law_name
  resource_group_name = data.azurerm_resource_group.core.name
}
