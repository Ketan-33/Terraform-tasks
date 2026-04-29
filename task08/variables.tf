variable "name_prefix" {
  type    = string
  default = "cmtr-9f1znn32-mod8"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "git_pat" {
  type      = string
  sensitive = true
  description = "GitHub Personal Access Token for ACR task"
}

variable "tags" {
  type = map(string)
  default = {
    Creator = "ketan_thansinghpardhi@epam.com"
  }
}