# the zones defined in this file aren't used by the core system,
# but are a preperation for shared/workspace services deployment.

# since shared services are in the core network, their dns link could exist once and must be defined here.


# Once the deployment of the app gateway is complete, we can proceed to include the required DNS zone for Nexus, which is dependent on the FQDN of the app gateway.
resource "azurerm_private_dns_zone" "nexus" {
  count = var.deploy_app_gateway ? 1 : 0
  name                = "nexus-${one(module.appgateway[*].app_gateway_fqdn)}"
  resource_group_name = azurerm_resource_group.core.name
  tags                = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}
