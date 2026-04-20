output "fqdn" {
  description = "The FQDN of the traffic manager profile"
  value       = azurerm_traffic_manager_profile.tm.fqdn
}

output "tm_id" {
  description = "id of tm"
  value       = azurerm_traffic_manager_profile.tm.id
}