variable "aks_name" {
  description = "Name of the Azure Kubernetes Service cluster"
  type        = string
}

variable "location" {
  description = "Azure region where the AKS cluster will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group containing the AKS cluster"
  type        = string
}

variable "acr_id" {
  description = "Resource ID of the Azure Container Registry to attach to the AKS cluster"
  type        = string
}

variable "keyvault_id" {
  description = "Resource ID of the Key Vault that AKS will access for secrets"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the AKS resources"
  type        = map(string)
}
