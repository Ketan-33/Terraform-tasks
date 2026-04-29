variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "cmtr-9f1znn32-mod8"
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "eastus"
}

variable "git_pat" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token for ACR task"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default = {
    Creator = "ketan_thansinghpardhi@epam.com"
  }
}