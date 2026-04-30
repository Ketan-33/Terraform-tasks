locals {
  # Resource names following naming convention
  # cmtr-9f1znn32-mod9-<abbreviation>
  firewall_subnet_name = "AzureFirewallSubnet"   # must be exactly this name
  pip_name             = "${var.name_prefix}-pip"
  firewall_name        = "${var.name_prefix}-afw"
  route_table_name     = "${var.name_prefix}-rt"
  ip_config_name       = "${var.name_prefix}-ipcfg"

  # App rule collection names
  app_rule_collection_name     = "${var.name_prefix}-app-rc"
  network_rule_collection_name = "${var.name_prefix}-net-rc"
  nat_rule_collection_name     = "${var.name_prefix}-nat-rc"
}