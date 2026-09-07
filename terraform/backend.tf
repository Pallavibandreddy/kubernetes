terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "pallavitfstate2026"
    container_name       = "tfstate"
    key                  = "aks-project.tfstate"
  }
}