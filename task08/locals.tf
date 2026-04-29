locals {
  name_prefix   = var.name_prefix
  rg_name       = join("-", [local.name_prefix, "rg"])
  aci_name      = join("-", [local.name_prefix, "ci"])
  acr_name      = replace(join("", [local.name_prefix, "cr"]), "-", "")
  aks_name      = join("-", [local.name_prefix, "aks"])
  keyvault_name = join("-", [local.name_prefix, "kv"])
  redis_name    = join("-", [local.name_prefix, "redis"])

  docker_image_name = join("-", [local.name_prefix, "app"])
}
