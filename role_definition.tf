data "azurerm_subscription" "current" {
}

data "azurerm_client_config" "current" {
}

resource "azurerm_role_definition" "role_definition" {
  for_each = local.builtin_role_definitions_dataset_from_json
  role_definition_id = each.value["name"]
  name               = each.value["properties"]["roleName"]
  description        = each.value["properties"]["description"]
  scope              = data.azurerm_subscription.current.id
  dynamic "permissions" {
    for_each = each.value["properties"]["permissions"]
    content {
       actions = tolist(permissions.value["actions"])
       not_actions = tolist(permissions.value["notActions"])
       data_actions = tolist(permissions.value["dataActions"])
       not_data_actions = tolist(permissions.value["notDataActions"])
    }
  }

  assignable_scopes = tolist(each.value["properties"]["assignableScopes"])
}

resource "azurerm_role_assignment" "role_assignment" {
  for_each           = azurerm_role_definition.role_definition
  name               = uuidv5("dns","ra.${each.value.name}.${data.azurerm_client_config.current.object_id}")
  scope              = data.azurerm_subscription.current.id
  role_definition_id = each.value.role_definition_resource_id
  principal_id       = data.azurerm_client_config.current.object_id
  description        = "Role assignment for ${data.azurerm_client_config.current.object_id} to ${each.value.description}"
}