terraform {

  backend "azurerm" {
    resource_group_name  = "rg1"
    storage_account_name = "ketanstorageacc"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

  }
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}