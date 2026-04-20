variable "name_prefix"{
    description = "Prefix for resource names"
    type        = string
}

variable "location" {
    description = "Azure region for resource deployment"
    type        = string
}
variable "kv_resource_group_name" {
    description = "Name of the resource group for Key Vault"
    type        = string
}
variable "kv_name" {
    description = "Name of the Key Vault"
    type        = string
}
variable "sql_admin_username" {
    description = "SQL Server admin username"
    type        = string
}

variable "sql_firewall_rule_name"{
    description = "Name of the SQL Firewall Rule"
    type        = string
}
variable "allowed_ip_address"{
    description = "Allowed IP address for SQL Firewall Rule"
    type        = string
}
variable "sql_db_sku"{
    description = "SKU for the SQL Database"
    type        = string
}
variable "asp_sku"{
    description = "SKU for the App Service Plan"
    type        = string
}
variable "dotnet_version"{
    description = "Version of .NET for the App Service"
    type        = string
}
variable "tags" {
    description = "Tags to apply to resources"
    type        = map(string)
}
variable "kv_secret_name_sql_admin"{
    description = "Name of the Key Vault secret for SQL admin password"
    type        = string
}
variable "kv_secret_name_sql_password"{
    description = "Name of the Key Vault secret for SQL database password"
    type        = string
}
