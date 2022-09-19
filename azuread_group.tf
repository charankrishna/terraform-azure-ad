data "azuread_client_config" "current" {}

resource "azuread_group" "ADGroup" {
  display_name     = var.aad_group_name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}