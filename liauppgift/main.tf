# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Resource Groups

# RG1 "prod-rg"
resource "azurerm_resource_group" "prod-rg" {
  name     = "prod-rg"
  location = "West Europe"
}

# RG2 "test-rg"
resource "azurerm_resource_group" "test-rg" {
  name     = "test-rg"
  location = "West Europe"
}

# RG3 "dev-rg"
resource "azurerm_resource_group" "dev-rg" {
  name     = "dev-rg"
  location = "West Europe"
}

# RG4 "hub-rg"
resource "azurerm_resource_group" "hub-rg" {
  name     = "hub-rg"
  location = "West Europe"
}

# RG5 "egetvnetrg"
resource "azurerm_resource_group" "egetvnetrg" {
  name     = "egetvnetrg"
  location = "West Europe"
}

# Prod-VM Public IP
resource "azurerm_public_ip" "prodpip" {
  name                = "prod-pip"
  location            = azurerm_resource_group.prod-rg.location
  resource_group_name = azurerm_resource_group.prod-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Dev-VM Public IP
resource "azurerm_public_ip" "devpip" {
  name                = "dev-pip"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
