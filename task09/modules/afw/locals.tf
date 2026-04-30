locals {
  name_prefix = var.name_prefix

  afw_name           = join("", [local.name_prefix, "afw"])
  afw_sku_name       = "AZFW_VNet"
  afw_subnet_name    = "AzureFirewallSubnet"
  afw_public_ip_name = join("", [local.name_prefix, "pip"])
  route_table_name   = join("", [local.name_prefix, "route-table"])
  route_name         = join("", [local.name_prefix, "route-afw"])
}