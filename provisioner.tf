
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.12.1"
    }
  }

  backend "azurerm" {}

  required_version = ">= 1.7.4"
}

provider "azurerm" {
  features {}
}

