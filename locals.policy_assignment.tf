# If Policy Assignments are specified in the archetype definition, generate a list of all Policy Assignment files from the built-in and custom library locations
locals {
  builtin_policy_assignments_from_json =  tolist(fileset(local.builtin_library_path, "**/policy_assignment_*.{json,json.tftpl}"))
  builtin_policy_assignments_from_yaml =  tolist(fileset(local.builtin_library_path, "**/policy_assignment_*.{yml,yml.tftpl,yaml,yaml.tftpl}"))
#  custom_policy_assignments_from_json  = tolist(fileset(local.custom_library_path, "**/policy_assignment_*.{json,json.tftpl}"))
#  custom_policy_assignments_from_yaml  = tolist(fileset(local.custom_library_path, "**/policy_assignment_*.{yml,yml.tftpl,yaml,yaml.tftpl}"))
}

# If Policy Assignment files exist, load content into dataset
locals {
  builtin_policy_assignments_dataset_from_json = try(length(local.builtin_policy_assignments_from_json) > 0, false) ? {
    for filepath in local.builtin_policy_assignments_from_json :
    filepath => jsondecode(templatefile("${local.builtin_library_path}/${filepath}", local.template_file_vars))
  } : null
  builtin_policy_assignments_dataset_from_yaml = try(length(local.builtin_policy_assignments_from_yaml) > 0, false) ? {
    for filepath in local.builtin_policy_assignments_from_yaml :
    filepath => yamldecode(templatefile("${local.builtin_library_path}/${filepath}", local.template_file_vars))
  } : null
#  custom_policy_assignments_dataset_from_json = try(length(local.custom_policy_assignments_from_json) > 0, false) ? {
#    for filepath in local.custom_policy_assignments_from_json :
#    filepath => jsondecode(templatefile("${local.custom_library_path}/${filepath}", local.template_file_vars))
#  } : null
#  custom_policy_assignments_dataset_from_yaml = try(length(local.custom_policy_assignments_from_yaml) > 0, false) ? {
#    for filepath in local.custom_policy_assignments_from_yaml :
#    filepath => yamldecode(templatefile("${local.custom_library_path}/${filepath}", local.template_file_vars))
#  } : null
}