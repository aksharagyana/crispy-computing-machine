# The following block of locals are used to avoid using
# empty object types in the code
locals {
  empty_list   = []
  empty_map    = {}
  empty_string = ""
}

# The following locals are used to convert basic input
# variables to locals before use elsewhere in the module
locals {
  root_id                 = var.root_id
  scope_id                = var.scope_id
  #  archetype_id            = var.archetype_id
  #  parameters              = var.parameters
  #  enforcement_mode        = var.enforcement_mode
  #  access_control          = var.access_control
  library_path            = var.library_path
  #  template_file_variables = var.template_file_variables
  default_location        = var.default_location
}

# The following locals are used in template functions to provide values
locals {
  core_template_file_variables = {
    root_scope_id             = basename(local.root_id)
    root_scope_resource_id    = azurerm_management_group.mg_cw.id
    current_scope_id          = basename(local.scope_id)
    current_scope_resource_id = local.scope_id
    default_location          = local.default_location
    location                  = local.default_location
    builtin                   = local.builtin_library_path
    builtin_library_path      = local.builtin_library_path
    custom                    = local.custom_library_path
    custom_library_path       = local.custom_library_path
    private_dns_zone_prefix   = var.private_dns_zone_prefix
    connectivity_location     = var.connectivity_location
  }
  template_file_vars = merge(
    #    local.template_file_variables,
    local.core_template_file_variables
  )
  #  template_file_vars = {}
}

locals {
  builtin_library_path          = "${path.module}/lib"
  custom_library_path_specified = try(length(local.library_path) > 0, false)
  custom_library_path           = local.custom_library_path_specified ? replace(local.library_path, "//$/", local.empty_string) : null
}