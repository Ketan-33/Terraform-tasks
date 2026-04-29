data "azurerm_client_config" "current" {}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

# Key Vault
module "keyvault" {
  source              = "./modules/keyvault"
  keyvault_name       = local.keyvault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# Redis Cache
module "redis" {
  source                    = "./modules/redis"
  redis_name                = local.redis_name
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  keyvault_id               = module.keyvault.id
  keyvault_access_policy_id = module.keyvault.id
  tags                      = var.tags
}

# ACR
module "acr" {
  source              = "./modules/acr"
  acr_name            = local.acr_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  docker_image_name   = local.docker_image_name
  git_pat             = var.git_pat
  tags                = var.tags
}

# AKS
module "aks" {
  source              = "./modules/aks"
  aks_name            = local.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  acr_id              = module.acr.id
  keyvault_id         = module.keyvault.id
  tags                = var.tags
}

# ACI
module "aci" {
  source              = "./modules/aci"
  aci_name            = local.aci_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  acr_login_server    = module.acr.login_server
  acr_username        = module.acr.admin_username
  acr_password        = module.acr.admin_password
  docker_image_name   = local.docker_image_name
  redis_hostname      = module.redis.hostname
  redis_primary_key   = module.redis.primary_key
  tags                = var.tags

  depends_on = [
    module.acr,  # image must be built first
    module.redis # secrets must exist
  ]
}

# K8s
resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    keyvault_name              = local.keyvault_name
    tenant_id                  = data.azurerm_client_config.current.tenant_id
    kubelet_identity_client_id = module.aks.kubelet_identity_client_id
  })

  wait_for {
    field {
      key   = "status.conditions.[0].status"
      value = "True"
    }
  }

  depends_on = [module.aks]
}

# K8s — Deployment manifest
resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    image = "${module.acr.login_server}/${local.docker_image_name}:latest"
  })

  depends_on = [
    kubectl_manifest.secret_provider,
    module.aks
  ]
}

# K8s — Service manifest
resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

# Data source to get LB IP from deployed K8s service
data "kubernetes_service" "app" {
  metadata {
    name      = "app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.service]
}