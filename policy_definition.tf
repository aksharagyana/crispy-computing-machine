resource "azurerm_policy_definition" "policy_definition" {
  for_each = local.builtin_policy_definitions_dataset_from_json

  name                = each.value["name"]
  policy_type         = each.value["properties"]["policyType"]
  mode                = each.value["properties"]["mode"]
  display_name        = each.value["properties"]["displayName"]
  description         = each.value["properties"]["description"]
  management_group_id = azurerm_management_group.mg_cw.id

  policy_rule = jsonencode(each.value["properties"]["policyRule"])
  metadata    = jsonencode(each.value["properties"]["metadata"])
  parameters  = jsonencode(each.value["properties"]["parameters"])

}
