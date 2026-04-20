resource "azurerm_service_plan" "this" {
  name                = var.asp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.asp_sku
  os_type             = "Linux"
  tags                = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id
  tags                = var.tags

  site_config {
    application_stack {
      dotnet_version = var.dotnet_version
    }
  }
  connection_string {
    name  = "SQLConnectionString"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }
}