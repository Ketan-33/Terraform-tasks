variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

# Variables for Azure Firewall configuration
variable "application_rules_protocol" {
  description = "Protocol for the application rule (e.g., Http, Https)"
  type = list(object({
    protocol_type = string
    port          = number
  }))
}

variable "aks_loadbalancer_ip" {
  description = "IP address of the AKS load balancer to allow in firewall rules"
  type        = string
}