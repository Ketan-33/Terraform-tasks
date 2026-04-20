variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}
variable "asp_name" {
  description = "Name of the App Service Plan"
  type        = string
}
variable "asp_sku" {
  description = "SKU for the App Service Plan"
  type        = string
}
variable "app_name" {
  description = "Name of the App Service"
  type        = string
}
variable "dotnet_version" {
  description = "Version of .NET for the App Service"
  type        = string
}
variable "sql_connection_string" {
  description = "Connection string for the SQL Database"
  type        = string
  sensitive   = true
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}