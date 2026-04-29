output "id"          { value = azurerm_key_vault.kv.id }
output "name"        { value = azurerm_key_vault.kv.name }
output "uri"         { value = azurerm_key_vault.kv.vault_uri }
output "tenant_id"   { value = data.azurerm_client_config.current.tenant_id }