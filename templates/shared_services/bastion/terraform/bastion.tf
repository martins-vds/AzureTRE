resource "azurerm_public_ip" "bastion" {
  name                = "pip-bas-${var.tre_id}"
  resource_group_name = data.azurerm_resource_group.core.name
  location            = data.azurerm_resource_group.core.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tre_shared_service_tags

  lifecycle { ignore_changes = [tags, zones] }
}

resource "azurerm_bastion_host" "bastion" {
  name                   = "bas-${var.tre_id}"
  resource_group_name    = data.azurerm_resource_group.core.name
  location               = data.azurerm_resource_group.core.location
  sku                    = "Standard"
  shareable_link_enabled = true
  tunneling_enabled      = true

  ip_configuration {
    name                 = "pip-bas-${var.tre_id}"
    subnet_id            = data.azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }

  tags = local.tre_shared_service_tags

  lifecycle { ignore_changes = [tags] }
}

