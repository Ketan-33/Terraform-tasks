variable "resource_groups" {
  description = "resource grps"
  type = map(object({
    name     = string
    location = string
  }))
}

variable "tags" {
  type        = map(string)
  description = "tag"
}

variable "asp_configs" {
  description = "app service plan"
  type = map(object({
    name               = string
    worker_count       = number
    resource_group_key = string
    sku                = string
    os_type            = string
  }))
}

variable "app_service_configs" {
  description = "app service configs"
  type = map(object({
    name               = string
    resource_group_key = string
    asp_key            = string
  }))
}

variable "ip_restriction" {
  description = "ip access levels"
  type = list(object({
    name     = string
    priority = number
    action   = string

    ip_address  = optional(string)
    service_tag = optional(string)
  }))
}

variable "traffic_manager" {
  description = "tm config"

  type = object({
    resource_group_key       = string
    traffic_routing_method   = string
    tm_name                  = string
    ttl_dns_config           = number
    relative_name_dns_config = string
  })
}
