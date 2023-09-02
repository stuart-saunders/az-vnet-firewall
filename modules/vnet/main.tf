resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  # edge_zone               = var.edge_zone
  # flow_timeout_in_minutes = var.flow_timeout_in_minutes

  # tags = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = local.subnets

  name                 = each.key
  resource_group_name  = azurerm_virtual_network.this.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes

}

resource "azurerm_firewall" "this" {
  for_each = local.firewall_subnet

  name = "firewall0"
  
  location            = var.location
  resource_group_name = var.resource_group_name
  
  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  ip_configuration {
    name = "config"
    subnet_id = azurerm_subnet.this["AzureFirewallSubnet"].id
  }
}