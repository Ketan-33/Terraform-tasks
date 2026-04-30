# Existing variables for resource naming and configuration
variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "rg_location" {
  description = "Location of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

# Variables for Azure Firewall configuration
variable "afw_sku_tier" {
  description = "SKU tier for Azure Firewall (e.g., Standard)"
  type        = string
  default     = "Standard"
}

variable "aks_subnet_id" {
  description = "ID of the existing AKS subnet to associate with the route table"
  type        = string
}


variable "application_rules_protocol" {
  description = "Protocol for the application rule (e.g., Http, Https)"
  type = list(object({
    protocol_type = string
    port          = number
  }))
}

variable "aks_lb_ip_address" {
  description = "IP address of the AKS load balancer to allow in firewall rules"
  type        = string
}