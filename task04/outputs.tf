output "vm_public_ip" {
  description = "Public IP of the Virtual Machine"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_fqdn" {
  description = "FQDN of the Virtual Machine"
  value       = azurerm_public_ip.main.fqdn
}