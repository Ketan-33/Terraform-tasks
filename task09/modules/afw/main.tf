# ── SUBNET ────────────────────────────────────────────────────
# AzureFirewallSubnet — name must be exactly this
resource "azurerm_subnet" "firewall" {
  name                 = local.firewall_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.fw_subnet_address_prefix]
}

# ── PUBLIC IP ─────────────────────────────────────────────────
resource "azurerm_public_ip" "firewall" {
  name                = local.pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true   # required per task
  }
}

# ── AZURE FIREWALL ────────────────────────────────────────────
resource "azurerm_firewall" "afw" {
  name                = local.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.fw_sku_name
  sku_tier            = var.fw_sku_tier

  ip_configuration {
    name                 = local.ip_config_name
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

# ── ROUTE TABLE ───────────────────────────────────────────────
# Forces all AKS egress through the firewall
resource "azurerm_route_table" "rt" {
  name                          = local.route_table_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = true

  route {
    name                   = "route-to-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.afw.ip_configuration[0].private_ip_address
  }
}

# Associate route table with AKS subnet
resource "azurerm_subnet_route_table_association" "aks" {
  subnet_id      = var.aks_subnet_id
  route_table_id = azurerm_route_table.rt.id
}

# ── APPLICATION RULE COLLECTION ───────────────────────────────
# Using dynamic blocks and for_each as required
resource "azurerm_firewall_application_rule_collection" "app" {
  for_each = { for rc in var.app_rule_collections : rc.name => rc }

  name                = local.app_rule_collection_name
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name             = rule.value.name
      source_addresses = rule.value.source_addresses
      target_fqdns     = rule.value.target_fqdns

      dynamic "protocol" {
        for_each = rule.value.protocols
        content {
          port = protocol.value.port
          type = protocol.value.type
        }
      }
    }
  }
}

# ── NETWORK RULE COLLECTION ───────────────────────────────────
resource "azurerm_firewall_network_rule_collection" "network" {
  for_each = { for rc in var.network_rule_collections : rc.name => rc }

  name                = local.network_rule_collection_name
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_addresses = rule.value.destination_addresses
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}

# ── NAT RULE COLLECTION ───────────────────────────────────────
# Translates inbound traffic on firewall public IP → AKS LB IP
resource "azurerm_firewall_nat_rule_collection" "nat" {
  name                = local.nat_rule_collection_name
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.resource_group_name
  priority            = 300
  action              = "Dnat"

  rule {
    name                  = "nat-http-to-aks-lb"
    source_addresses      = ["*"]
    destination_addresses = [azurerm_public_ip.firewall.ip_address]
    destination_ports     = ["80"]
    protocols             = ["TCP"]
    translated_address    = var.aks_loadbalancer_ip
    translated_port       = "80"
  }

  rule {
    name                  = "nat-https-to-aks-lb"
    source_addresses      = ["*"]
    destination_addresses = [azurerm_public_ip.firewall.ip_address]
    destination_ports     = ["443"]
    protocols             = ["TCP"]
    translated_address    = var.aks_loadbalancer_ip
    translated_port       = "443"
  }
}