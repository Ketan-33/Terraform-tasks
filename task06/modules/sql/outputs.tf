output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "sql_connection_string" {
  description = "Connection string for the SQL Database"
  value       = "Server=${azurerm_mssql_server.this.fully_qualified_domain_name};Database=${azurerm_mssql_database.this.name};User ID=${var.sql_admin_username};Password=${random_password.sql_password.result};Encrypt=true;Connection Timeout=30;"
  sensitive   = true
}