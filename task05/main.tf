module "RG" {
  source = "./modules/resource_group"

  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location

  tags = var.tags
}

module "Asp" {
  source = "./modules/app_service_plan"

  for_each = var.asp_configs

  name                = each.value.name
  location            = module.RG[each.value.resource_group_key].location
  worker_count        = each.value.worker_count
  resource_group_name = module.RG[each.value.resource_group_key].name
  sku_name            = each.value.sku

  os_type = each.value.os_type

  tags = var.tags
}

module "App" {
  source = "./modules/app_service"

  for_each = var.app_service_configs

  name                = each.value.name
  location            = module.RG[each.value.resource_group_key].location
  resource_group_name = module.RG[each.value.resource_group_key].name
  app_service_plan_id = module.Asp[each.value.asp_key].id
  tags                = var.tags

  ip_restriction = var.ip_restriction
}

module "TM" {
  source = "./modules/traffic_manager"


  resource_group_name      = module.RG[var.traffic_manager.resource_group_key].name
  traffic_routing_method   = var.traffic_manager.traffic_routing_method
  tm_name                  = var.traffic_manager.tm_name
  ttl_dns_config           = var.traffic_manager.ttl_dns_config
  relative_name_dns_config = var.traffic_manager.relative_name_dns_config

  endpoints = {
    for app_key, app in module.App :
    app_key => {
      name               = app.name
      target_resource_id = module.App[app_key].id #app.id
    }
  }

  tags = var.tags
} 