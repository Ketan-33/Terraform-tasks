# Data sources to reference existing resources
data "azurerm_resource_group" "RG" {
  name = local.resource_group_name
}

# Data source to reference the existing virtual network
data "azurerm_virtual_network" "VNet" {
  name                = local.virtual_network_name
  resource_group_name = data.azurerm_resource_group.RG.name
}

# Data source to reference the existing subnet
data "azurerm_subnet" "aks_subnet" {
  name                 = local.aks_subnet_name
  resource_group_name  = data.azurerm_resource_group.RG.name
  virtual_network_name = data.azurerm_virtual_network.VNet.name
}

# Azure Firewall Module
module "afw" {
  source = "./modules/afw"

  name_prefix                = var.name_prefix
  rg_name                    = data.azurerm_resource_group.RG.name
  rg_location                = data.azurerm_resource_group.RG.location
  vnet_name                  = data.azurerm_virtual_network.VNet.name
  aks_subnet_id              = data.azurerm_subnet.aks_subnet.id
  application_rules_protocol = var.application_rules_protocol
  aks_lb_ip_address          = var.aks_loadbalancer_ip
}