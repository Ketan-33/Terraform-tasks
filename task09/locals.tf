locals {
  name_prefix = var.name_prefix

  resource_group_name  = join("", [local.name_prefix, "rg"])
  virtual_network_name = join("", [local.name_prefix, "vnet"])
  aks_subnet_name      = "aks-snet"
}