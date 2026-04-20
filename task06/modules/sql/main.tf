resource "random_password" "sql_password" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}|;:,.<>?/~"
}

resource "azurerm_mssql_server" "this" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_password.result
  tags                         = var.tags
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "allow_azure_services"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "allow_specific_ip" {
  name             = var.firewall_rule_name
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}

resource "azurerm_mssql_database" "this" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.this.id
  sku_name  = var.sql_db_sku
  tags      = var.tags
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.kv_secret_name_sql_password
  value        = random_password.sql_password.result
  key_vault_id = var.key_vault_id
}


