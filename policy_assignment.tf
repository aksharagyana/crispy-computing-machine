resource "azurerm_management_group_policy_assignment" "policy_assignment" {
  for_each             = local.builtin_policy_assignments_dataset_from_json
  name                 = each.value["name"]
  location             = each.value["location"]
  dynamic "identity" {
    for_each = lower(each.value["identity"]["type"]) == "systemassigned" || lower(each.value["identity"]["type"]) == "userAssigned" ? [1] : []
    content {
      type = each.value["identity"]["type"]
    }
  }
  management_group_id  = azurerm_management_group.mg_cw.id
  policy_definition_id = each.value["properties"]["policyDefinitionId"]
  description          = each.value["properties"]["description"]
  display_name         = each.value["properties"]["displayName"]
  enforce              = try(lower(each.value["properties"]["enforcementMode"]) == "default" || lower(each.value["properties"]["enforcementMode"]) == "true", false) ? true : false
  dynamic "non_compliance_message" {
    for_each = try(each.value["properties"]["nonComplianceMessages"], {})
    content {
      content = non_compliance_message.value["message"]
    }
  }
  parameters = jsonencode(each.value["properties"]["parameters"])
  not_scopes = each.value["properties"]["notScopes"]

}