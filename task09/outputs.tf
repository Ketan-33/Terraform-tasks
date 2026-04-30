output "azure_firewall_public_ip" {
  value = module.afw.firewall.public_ip_address
}

output "azure_firewall_private_ip" {
  value = module.afw.firewall.private_ip_address
}