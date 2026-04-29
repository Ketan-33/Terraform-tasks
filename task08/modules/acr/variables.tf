variable "acr_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "docker_image_name" { type = string }
variable "git_pat" {
  type      = string
  sensitive = true
}
variable "tags" { type = map(string) }