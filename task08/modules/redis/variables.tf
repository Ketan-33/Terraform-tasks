variable "redis_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "keyvault_id" { type = string }
variable "keyvault_access_policy_id" { type = string }
variable "tags" { type = map(string) }