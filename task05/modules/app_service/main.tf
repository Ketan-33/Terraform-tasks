resource "azurerm_windows_web_app" "windows_web_app" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_service_plan_id
  tags                = var.tags

  site_config {

    dynamic "ip_restriction" {
      for_each = var.ip_restriction

      content {
        name     = ip_restriction.value.name
        priority = ip_restriction.value.priority
        action   = ip_restriction.value.action

        ip_address  = try(ip_restriction.value.ip_address, null)
        service_tag = try(ip_restriction.value.service_tag, null)
      }
    }
    ip_restriction_default_action = "Deny"
  }

}