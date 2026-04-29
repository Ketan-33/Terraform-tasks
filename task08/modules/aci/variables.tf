variable "aci_name" {
  description = "Name of the Azure Container Instance"
  type        = string
}

variable "location" {
  description = "Azure region where the ACI will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group containing the ACI"
  type        = string
}

variable "acr_login_server" {
  description = "Login server URL of the Azure Container Registry"
  type        = string
}

variable "acr_username" {
  description = "Admin username for the Azure Container Registry"
  type        = string
}

variable "acr_password" {
  description = "Admin password for the Azure Container Registry"
  type        = string
  sensitive   = true
}

variable "docker_image_name" {
  description = "Name of the Docker image to deploy in the container instance"
  type        = string
}

variable "redis_hostname" {
  description = "Hostname of the Redis cache used by the application"
  type        = string
}

variable "redis_primary_key" {
  description = "Primary access key for the Redis cache"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the container instance resources"
  type        = map(string)
}
