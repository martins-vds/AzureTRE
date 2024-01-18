resource "azurerm_route_table" "rt" {
  name                          = "rt-${var.tre_id}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  disable_bgp_route_propagation = false
  tags                          = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet_route_table_association" "rt_azure_firewall_subnet_association" {
  subnet_id      = azurerm_subnet.azure_firewall.id
  route_table_id = azurerm_route_table.rt.id
}

resource "azurerm_subnet_route_table_association" "rt_app_gw_subnet_association" {
  subnet_id      = azurerm_subnet.app_gw.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [ azurerm_subnet_route_table_association.rt_azure_firewall_subnet_association ]
}

resource "azurerm_subnet_route_table_association" "rt_web_app_subnet_association" {
  subnet_id      = azurerm_subnet.web_app.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [ azurerm_subnet_route_table_association.rt_app_gw_subnet_association ]
}

resource "azurerm_subnet_route_table_association" "rt_shared_subnet_association" {
  subnet_id      = azurerm_subnet.shared.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [ azurerm_subnet_route_table_association.rt_web_app_subnet_association ]
}

resource "azurerm_subnet_route_table_association" "rt_resource_processor_association" {
  subnet_id      = azurerm_subnet.resource_processor.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [ azurerm_subnet_route_table_association.rt_shared_subnet_association ]
}

resource "azurerm_subnet_route_table_association" "rt_airlock_processor_association" {
  subnet_id      = azurerm_subnet.airlock_processor.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [ azurerm_subnet_route_table_association.rt_resource_processor_association ]
}

resource "azurerm_subnet_route_table_association" "rt_airlock_notification_association" {
  subnet_id      = azurerm_subnet.airlock_notification.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [ azurerm_subnet_route_table_association.rt_airlock_processor_association ]
}

resource "azurerm_subnet_route_table_association" "rt_airlock_storage_association" {
  subnet_id      = azurerm_subnet.airlock_storage.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [ azurerm_subnet_route_table_association.rt_airlock_notification_association ]
}

resource "azurerm_subnet_route_table_association" "rt_airlock_events_association" {
  subnet_id      = azurerm_subnet.airlock_events.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [ azurerm_subnet_route_table_association.rt_airlock_storage_association ]
}

resource "azurerm_subnet_route_table_association" "rt_firewall_management_association" {
  subnet_id      = azurerm_subnet.firewall_management.id
  route_table_id = azurerm_route_table.rt.id

  depends_on = [ azurerm_subnet_route_table_association.rt_airlock_events_association ]
}
