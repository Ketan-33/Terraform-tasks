output "firewall" {
  value = {
    public_ip_address  = azurerm_public_ip.afw_public_ip.ip_address
    private_ip_address = azurerm_firewall.afw.ip_configuration[0].private_ip_address
  }
}