output "azure_firewall_public_ip" {
  description = "Azure Firewall Public IP address"
  value       = azurerm_public_ip.firewall.ip_address
}

output "azure_firewall_private_ip" {
  description = "Azure Firewall Private IP address"
  value       = azurerm_firewall.afw.ip_configuration[0].private_ip_address
}

output "firewall_name" {
  value = azurerm_firewall.afw.name
}

output "route_table_id" {
  value = azurerm_route_table.rt.id
}