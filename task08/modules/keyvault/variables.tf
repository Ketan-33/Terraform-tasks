variable "keyvault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region where the Key Vault will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group containing the Key Vault"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Key Vault resources"
  type        = map(string)
}
