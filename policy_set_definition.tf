resource "azurerm_policy_set_definition" "policy_set_definition" {
  for_each = local.builtin_policy_set_definitions_dataset_from_json

  name                = each.value["name"]
  policy_type         = each.value["properties"]["policyType"]
  display_name        = each.value["properties"]["displayName"]
  description         = each.value["properties"]["description"]
  management_group_id = azurerm_management_group.mg_cw.id

  parameters = jsonencode(each.value["properties"]["parameters"])
  dynamic "policy_definition_reference" {
    for_each = each.value["properties"]["policyDefinitions"]
    content {
      policy_definition_id = policy_definition_reference.value["policyDefinitionId"]
      policy_group_names   = toset(policy_definition_reference.value["groupNames"])
      reference_id         = policy_definition_reference.value["policyDefinitionReferenceId"]
      parameter_values     = jsonencode(policy_definition_reference.value["parameters"])
    }
  }
  metadata = jsonencode(each.value["properties"]["metadata"])
}