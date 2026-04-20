resource_groups = {
  RG1 = {
    name     = "cmaz-9f1znn32-mod5-rg-01"
    location = "eastus"
  }

  RG2 = {
    name     = "cmaz-9f1znn32-mod5-rg-02"
    location = "westus"
  }

  RG3 = {
    name     = "cmaz-9f1znn32-mod5-rg-03"
    location = "canadacentral"
  }
}

tags = {
  Creator = "ketan_thansinghpardhi@epam.com"
}

asp_configs = {
  asp1 = {
    name               = "cmaz-9f1znn32-mod5-asp-01"
    worker_count       = 2
    resource_group_key = "RG1"
    os_type            = "Windows"
    sku                = "S1"
  }

  asp2 = {
    name               = "cmaz-9f1znn32-mod5-asp-02"
    worker_count       = 1
    resource_group_key = "RG2"
    os_type            = "Windows"
    sku                = "S1"
  }
}

app_service_configs = {
  app1 = {
    name               = "cmaz-9f1znn32-mod5-app-01"
    resource_group_key = "RG1"
    asp_key            = "asp1"
  }

  app2 = {
    name               = "cmaz-9f1znn32-mod5-app-02"
    resource_group_key = "RG2"
    asp_key            = "asp2"
  }
}

ip_restriction = [
  {
    name       = "allow-ip"
    priority   = 100
    action     = "Allow"
    ip_address = "18.153.146.156/32"
  },

  {
    name        = "allow-tm"
    priority    = 110
    action      = "Allow"
    service_tag = "AzureTrafficManager"
  },

  {
    name       = "Deny all"
    priority   = 2147483647
    action     = "Deny"
    ip_address = "0.0.0.0/0"
  }
]

traffic_manager = {
  traffic_routing_method   = "Performance"
  resource_group_key       = "RG3"
  tm_name                  = "cmaz-9f1znn32-mod5-traf"
  ttl_dns_config           = 30
  relative_name_dns_config = "cmaz-9f1znn32-mod5-trafffenddnidnend"
}
