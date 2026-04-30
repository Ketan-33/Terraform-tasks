resource "azurerm_subnet" "subnet" {
  name                 = local.afw_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.10.0/24"]
}

resource "azurerm_public_ip" "afw_public_ip" {
  name                = local.afw_public_ip_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_firewall" "afw" {
  name                = local.afw_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku_name            = local.afw_sku_name
  sku_tier            = var.afw_sku_tier

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet.id
    public_ip_address_id = azurerm_public_ip.afw_public_ip.id
  }

}


resource "azurerm_route_table" "rt" {
  name                = local.route_table_name
  resource_group_name = var.rg_name
  location            = var.rg_location
}

resource "azurerm_route" "route_to_afw" {
  name                   = local.route_name
  resource_group_name    = var.rg_name
  route_table_name       = azurerm_route_table.rt.name
  address_prefix         = "10.1.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.afw.ip_configuration[0].private_ip_address
}


resource "azurerm_subnet_route_table_association" "association" {
  subnet_id      = var.aks_subnet_id
  route_table_id = azurerm_route_table.rt.id
}


# Firewall application rules
resource "azurerm_firewall_application_rule_collection" "app_rule_collection" {
  name                = join("", [local.name_prefix, "app-rule-collection"])
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.rg_name
  priority            = 100
  action              = "Allow"

  rule {
    name             = "allow-web"
    source_addresses = ["*"]
    target_fqdns     = ["microsoft.com", "docker.io"]

    dynamic "protocol" {
      for_each = var.application_rules_protocol
      content {
        type = protocol.value.protocol_type
        port = protocol.value.port
      }
    }
  }
}

# Firewall network rules
resource "azurerm_firewall_network_rule_collection" "net_rule_collection" {
  name                = join("", [local.name_prefix, "net-rule-collection"])
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.rg_name
  priority            = 200
  action              = "Allow"

  rule {
    name                  = "allow-internet"
    source_addresses      = ["*"]
    destination_addresses = ["*"]
    destination_ports     = ["80", "443"]
    protocols             = ["TCP"]
  }
}

# Firewall NAT rules
resource "azurerm_firewall_nat_rule_collection" "nat_rule_collection" {
  name                = join("", [local.name_prefix, "nat-rule-collection"])
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.rg_name
  priority            = 300
  action              = "Dnat"

  rule {
    name                  = "nginx-rule"
    source_addresses      = ["*"]
    destination_ports     = ["80"]
    destination_addresses = [azurerm_public_ip.afw_public_ip.ip_address]
    translated_address    = var.aks_lb_ip_address
    translated_port       = "80"
    protocols             = ["TCP"]
  }
}