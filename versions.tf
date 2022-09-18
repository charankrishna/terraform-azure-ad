terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.0.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate14662"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
  }
}