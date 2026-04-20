resource "azurerm_traffic_manager_profile" "tm" {
  name                   = var.tm_name
  resource_group_name    = var.resource_group_name
  traffic_routing_method = var.traffic_routing_method

  dns_config {
    relative_name = var.relative_name_dns_config
    ttl           = var.ttl_dns_config
  }

  monitor_config {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 10
    tolerated_number_of_failures = 3
  }

  tags = var.tags

}

resource "azurerm_traffic_manager_azure_endpoint" "tm_ep" {
  for_each = var.endpoints

  name               = each.value.name
  profile_id         = azurerm_traffic_manager_profile.tm.id
  target_resource_id = each.value.target_resource_id
}