# Reference existing Resource Group
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Reference existing VNet
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

# Reference existing AKS subnet
data "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

module "afw" {
  source = "./modules/afw"

  location            = var.location
  name_prefix         = local.name_prefix
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
  vnet_id             = data.azurerm_virtual_network.vnet.id
  aks_subnet_id       = data.azurerm_subnet.aks.id
  aks_loadbalancer_ip = var.aks_loadbalancer_ip
}