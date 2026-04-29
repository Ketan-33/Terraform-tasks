variable "aci_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "acr_login_server" { type = string }
variable "acr_username" { type = string }
variable "acr_password" {
  type      = string
  sensitive = true
}
variable "docker_image_name" { type = string }
variable "redis_hostname" { type = string }
variable "redis_primary_key" {
  type      = string
  sensitive = true
}
variable "tags" { type = map(string) }