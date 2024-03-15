data "azurerm_client_config" "core" {}

resource "azurerm_management_group" "mg_cw" {
  display_name = "CW"

  parent_management_group_id = null
}

resource "azurerm_management_group" "mg_launch_zone" {
  display_name = "Launch Zone"
  parent_management_group_id = null
}

resource "azurerm_management_group" "mg_platform" {
  display_name = "Platform"
  parent_management_group_id = azurerm_management_group.mg_cw.id
}

resource "azurerm_management_group" "mg_landing_zones" {
  display_name = "Landing Zone"
  parent_management_group_id = azurerm_management_group.mg_cw.id
}

resource "azurerm_management_group" "mg_decomissioned" {
  display_name = "Decommissioned"
  parent_management_group_id = azurerm_management_group.mg_cw.id
}

resource "azurerm_management_group" "mg_sandbox" {
  display_name = "Sandbox"
  parent_management_group_id = azurerm_management_group.mg_cw.id
}

resource "azurerm_management_group" "mg_security" {
  display_name = "Security"
  parent_management_group_id = azurerm_management_group.mg_platform.id
}

resource "azurerm_management_group" "mg_identity" {
  display_name = "Identity"
  parent_management_group_id = azurerm_management_group.mg_platform.id
}

resource "azurerm_management_group" "mg_management" {
  display_name = "Management"
  parent_management_group_id = azurerm_management_group.mg_platform.id
}

resource "azurerm_management_group" "mg_connectivity" {
  display_name = "Connectivity"
  parent_management_group_id = azurerm_management_group.mg_platform.id
}

resource "azurerm_management_group" "mg_workloads" {
  display_name = "Workloads"
  parent_management_group_id = azurerm_management_group.mg_landing_zones.id
}
