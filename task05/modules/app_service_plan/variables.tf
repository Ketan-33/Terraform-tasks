variable "name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "location" {
  description = "The location of the App Service Plan"
  type        = string
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "os_type" {
  description = "os type"
  type        = string
}

variable "sku_name" {
  description = "sku name"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the App Service Plan"
  type        = map(string)
}

variable "worker_count" {
  description = "The number of workers to be allocated to the App Service Plan"
  type        = number
}