output "builtin_policy_definitions_from_json" {
  value = local.builtin_policy_definitions_from_json
}

#output "builtin_policy_definitions_dataset_from_json" {
#  value = local.builtin_policy_definitions_dataset_from_json
#}

output "mg_id" {
  value = azurerm_management_group.mg_cw.id
}



output "subscription_id" {
  value = data.azurerm_subscription.current.id
}