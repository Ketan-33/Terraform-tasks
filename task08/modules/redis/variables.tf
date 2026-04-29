variable "redis_name" {
  description = "Name of the Azure Redis Cache instance"
  type        = string
}

variable "location" {
  description = "Azure region where the Redis Cache will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group containing the Redis Cache"
  type        = string
}

variable "keyvault_id" {
  description = "Resource ID of the Key Vault used to store Redis secrets"
  type        = string
}

variable "keyvault_access_policy_id" {
  description = "Resource ID of the Key Vault access policy granting Redis secret access"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Redis Cache resources"
  type        = map(string)
}
