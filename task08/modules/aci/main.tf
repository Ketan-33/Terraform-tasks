resource "azurerm_container_group" "aci" {
  name                = var.aci_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  restart_policy      = "Always"
  sku                 = "Standard"

  # DNS name label — gives FQDN
  dns_name_label = var.aci_name

  image_registry_credential {
    server   = var.acr_login_server
    username = var.acr_username
    password = var.acr_password
  }

  container {
    name   = var.aci_name
    image  = "${var.acr_login_server}/${var.docker_image_name}:latest"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }

    # Regular env vars
    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = "6380"
      REDIS_SSL_MODE = "True"
    }

    # Secure env vars — pulled from Key Vault
    secure_environment_variables = {
      REDIS_URL = var.redis_hostname
      REDIS_PWD = var.redis_primary_key
    }
  }

  tags = var.tags
}
