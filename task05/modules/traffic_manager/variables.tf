variable "resource_group_name" {
  description = "rg name"
  type        = string
}

variable "traffic_routing_method" {
  description = "traffic routing method"
  type        = string
}

variable "tags" {
  description = "tag"
  type        = map(string)
}

variable "tm_name" {
  description = "name of tm"
  type        = string
}

variable "ttl_dns_config" {
  description = "ttl(how long the dns rec. is cached by browser and resolver)"
  type        = number
}

variable "relative_name_dns_config" {
  description = "relative name of dns config"
  type        = string
}

variable "endpoints" {
  description = "ep"
  type = map(object({
    name               = string
    target_resource_id = string
  }))
}