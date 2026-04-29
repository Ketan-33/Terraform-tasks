resource "azurerm_redis_cache" "redis" {
  name                 = var.redis_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  capacity             = 2
  family               = "C"
  sku_name             = "Basic"
  non_ssl_port_enabled = false # SSL only — port 6380

  tags = var.tags
}

# Store redis hostname in Key Vault
resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = "redis-hostname"
  value        = azurerm_redis_cache.redis.hostname
  key_vault_id = var.keyvault_id

  depends_on = [var.keyvault_access_policy_id]
}

# Store redis primary key in Key Vault
resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = "redis-primary-key"
  value        = azurerm_redis_cache.redis.primary_access_key
  key_vault_id = var.keyvault_id

  depends_on = [var.keyvault_access_policy_id]
}