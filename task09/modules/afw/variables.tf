variable "location" {
  type        = string
  description = "Azure region"
}

variable "name_prefix" {
  type        = string
  description = "Naming prefix for resources"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "vnet_name" {
  type        = string
  description = "Existing VNet name"
}

variable "vnet_id" {
  type        = string
  description = "Existing VNet ID"
}

variable "aks_subnet_id" {
  type        = string
  description = "Existing AKS subnet ID"
}

variable "aks_loadbalancer_ip" {
  type        = string
  description = "AKS Load Balancer public IP"
}

variable "fw_sku_name" {
  type        = string
  description = "Firewall SKU name"
  default     = "AZFW_VNet"
}

variable "fw_sku_tier" {
  type        = string
  description = "Firewall SKU tier"
  default     = "Standard"
}

variable "fw_subnet_address_prefix" {
  type        = string
  description = "Address prefix for AzureFirewallSubnet"
  default     = "10.0.1.0/26"   # must be at least /26
}

variable "app_rule_collections" {
  description = "Application rule collections for the firewall"
  type = list(object({
    name     = string
    priority = number
    action   = string
    rules = list(object({
      name              = string
      source_addresses  = list(string)
      target_fqdns      = list(string)
      protocols = list(object({
        port = string
        type = string
      }))
    }))
  }))
  default = [
    {
      name     = "aks-app-rules"
      priority = 100
      action   = "Allow"
      rules = [
        {
          name             = "allow-aks-fqdns"
          source_addresses = ["10.0.0.0/24"]
          target_fqdns = [
            "*.hcp.eastus.azmk8s.io",
            "mcr.microsoft.com",
            "*.data.mcr.microsoft.com",
            "management.azure.com",
            "login.microsoftonline.com",
            "packages.microsoft.com",
            "acs-mirror.azureedge.net",
            "*.docker.io",
            "production.cloudflare.docker.com",
            "*.azurecr.io",
            "*.blob.core.windows.net",
            "*.ubuntu.com",
            "security.ubuntu.com",
            "azure.archive.ubuntu.com",
            "changelogs.ubuntu.com"
          ]
          protocols = [
            { port = "80",  type = "Http"  },
            { port = "443", type = "Https" }
          ]
        }
      ]
    }
  ]
}

variable "network_rule_collections" {
  description = "Network rule collections for the firewall"
  type = list(object({
    name     = string
    priority = number
    action   = string
    rules = list(object({
      name                  = string
      source_addresses      = list(string)
      destination_addresses = list(string)
      destination_ports     = list(string)
      protocols             = list(string)
    }))
  }))
  default = [
    {
      name     = "aks-network-rules"
      priority = 200
      action   = "Allow"
      rules = [
        {
          name                  = "allow-aks-apiserver"
          source_addresses      = ["10.0.0.0/24"]
          destination_addresses = ["AzureCloud.EastUS"]
          destination_ports     = ["443", "9000"]
          protocols             = ["TCP"]
        },
        {
          name                  = "allow-ntp"
          source_addresses      = ["10.0.0.0/24"]
          destination_addresses = ["*"]
          destination_ports     = ["123"]
          protocols             = ["UDP"]
        },
        {
          name                  = "allow-dns"
          source_addresses      = ["10.0.0.0/24"]
          destination_addresses = ["*"]
          destination_ports     = ["53"]
          protocols             = ["TCP", "UDP"]
        },
        {
          name                  = "allow-azure-monitor"
          source_addresses      = ["10.0.0.0/24"]
          destination_addresses = ["AzureMonitor"]
          destination_ports     = ["443"]
          protocols             = ["TCP"]
        }
      ]
    }
  ]
}