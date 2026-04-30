variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

variable "name_prefix" {
  type        = string
  description = "Naming prefix for all resources"
  default     = "cmtr-9f1znn32-mod9"
}

variable "resource_group_name" {
  type        = string
  description = "Existing resource group name"
  default     = "cmtr-9f1znn32-mod9-rg"
}

variable "vnet_name" {
  type        = string
  description = "Existing VNet name"
  default     = "cmtr-9f1znn32-mod9-vnet"
}

variable "aks_subnet_name" {
  type        = string
  description = "Existing AKS subnet name"
  default     = "aks-snet"
}

variable "aks_loadbalancer_ip" {
  type        = string
  description = "AKS Load Balancer public IP address"
}