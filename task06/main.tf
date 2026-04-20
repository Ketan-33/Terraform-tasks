data "azurerm_key_vault" "existing" {
  name                = var.kv_name
  resource_group_name = var.kv_resource_group_name
}

resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

module "sql" {
  source = "./modules/sql"

  resource_group_name         = azurerm_resource_group.this.name
  location                    = azurerm_resource_group.this.location
  sql_server_name             = local.sql_server_name
  sql_db_name                 = local.sql_db_name
  sql_db_sku                  = var.sql_db_sku
  sql_admin_username          = var.sql_admin_username
  firewall_rule_name          = var.sql_firewall_rule_name
  allowed_ip_address          = var.allowed_ip_address
  key_vault_name              = var.kv_name
  key_vault_id                = data.azurerm_key_vault.existing.id
  kv_secret_name_sql_admin    = var.kv_secret_name_sql_admin
  kv_secret_name_sql_password = var.kv_secret_name_sql_password
  tags                        = var.tags
}

module "webapp" {
  source = "./modules/webapp"

  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  asp_name              = local.asp_name
  app_name              = local.app_name
  asp_sku               = var.asp_sku
  dotnet_version        = var.dotnet_version
  sql_connection_string = module.sql.sql_connection_string
  tags                  = var.tags
}