resource "azurerm_resource_group" "this" {
  name = "az-firewall-rg"
  location = "uksouth"
}

module "vnets" {
  source = "./modules/vnet"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  
  name          = var.vnet.name
  address_space = var.vnet.address_space

  subnets = var.subnets

}