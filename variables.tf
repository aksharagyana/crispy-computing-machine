variable "root_id" {
  type    = string
  default = "CW"
}

variable "library_path" {
  type        = string
  description = "If specified, sets the path to a custom library folder for archetype artefacts."
  default     = ""
}

variable "scope_id" {
  type        = string
  description = "Specifies the scope to apply the archetype resources against."

  validation {
    condition     = can(regex("^\\/providers\\/Microsoft\\.Management\\/managementGroups\\/[a-zA-Z0-9_\\(\\)-\\.]{1,88}[a-zA-Z0-9_\\(\\)\\-]$", var.scope_id)) || can(regex("^/subscriptions/[a-zA-Z0-9-_\\(\\)\\.]{1,36}$", var.scope_id))
    error_message = "The scope_id value must be a valid Subscription or Management Group ID."
  }
}

variable "default_location" {
  type        = string
  description = "Sets the default location used for resource deployments where needed."
}

variable "private_dns_zone_prefix" {
  type        = string
  description = "A prefix for the Private DNS Zone. Must be a valid name."
}

variable "connectivity_location" {
  type        = string
  description = "The Azure Region where the Private link should exist."
}
