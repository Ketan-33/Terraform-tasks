variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "location" {
  description = "Azure region where the ACR will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group containing the ACR"
  type        = string
}

variable "docker_image_name" {
  description = "Name of the Docker image to be built by the ACR task"
  type        = string
}

variable "git_pat" {
  description = "GitHub Personal Access Token used by the ACR task to access the source repository"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the ACR resources"
  type        = map(string)
}
