resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = var.tags
}

# ACR Task — builds Docker image from GitHub source
resource "azurerm_container_registry_task" "build" {
  name                  = "build-task"
  container_registry_id = azurerm_container_registry.acr.id

  platform {
    os           = "Linux"
    architecture = "amd64"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/Ketan-33/task05.git#main:task08/application"
    context_access_token = var.git_pat
    image_names          = ["${var.docker_image_name}:latest"]
    push_enabled         = true
  }
}

# Schedule — trigger ACR task automatically
resource "azurerm_container_registry_task_schedule_run_now" "trigger" {
  container_registry_task_id = azurerm_container_registry_task.build.id
}
