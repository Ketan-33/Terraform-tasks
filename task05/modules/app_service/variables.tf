variable "name" {
  description = "name of web app"
  type        = string
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "location" {
  description = "location of web app"
  type        = string
}

variable "app_service_plan_id" {
  description = "id of app service plan"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource group"
  type        = map(string)
}

variable "ip_restriction" {
  description = "List of IP restriction rules"
  type = list(object({
    name     = string
    priority = number
    action   = string

    ip_address  = optional(string)
    service_tag = optional(string)
  }))
}