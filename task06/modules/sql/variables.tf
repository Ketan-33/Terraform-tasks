variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}
variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}
variable "sql_db_name" {
  description = "Name of the SQL Database"
  type        = string
}
variable "sql_db_sku" {
  description = "SKU for the SQL Database"
  type        = string
}
variable "sql_admin_username" {
  description = "SQL Server admin username"
  type        = string
}
variable "firewall_rule_name" {
  description = "Name of the SQL Firewall Rule"
  type        = string
}
variable "allowed_ip_address" {
  description = "Allowed IP address for SQL Firewall Rule"
  type        = string
}
variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}
variable "kv_secret_name_sql_admin" {
  description = "Name of the Key Vault secret for SQL admin password"
  type        = string
}
variable "kv_secret_name_sql_password" {
  description = "Name of the Key Vault secret for SQL database password"
  type        = string
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}